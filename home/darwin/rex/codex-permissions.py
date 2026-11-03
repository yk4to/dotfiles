# Upsert a Codex permission profile that lets sandboxed commands reach the Rex server.
# The Codex app keeps its own state in config.toml, so edit only the keys below.
import sys
from pathlib import Path

import tomlkit

path = Path(sys.argv[1])
socket = sys.argv[2]

before = path.read_text() if path.exists() else ""
doc = tomlkit.parse(before)

# Keep a default the user chose; default_permissions can't be combined with sandbox_mode.
if "default_permissions" not in doc and "sandbox_mode" not in doc:
    doc["default_permissions"] = "rex"

sockets = tomlkit.table()
sockets[socket] = "allow"

network = tomlkit.table()
network["enabled"] = True
network["mode"] = "limited"
network["unix_sockets"] = sockets

profile = tomlkit.table()
profile["description"] = "Workspace access plus the Rex server socket"
profile["extends"] = ":workspace"
profile["network"] = network

if "permissions" not in doc:
    doc["permissions"] = tomlkit.table(is_super_table=True)
doc["permissions"]["rex"] = profile

# Without the proxy, an enabled network is unrestricted rather than limited to the socket.
if "features" not in doc:
    doc["features"] = tomlkit.table()
if not isinstance(doc["features"].get("network_proxy"), dict):
    doc["features"]["network_proxy"] = tomlkit.table()
doc["features"]["network_proxy"]["enabled"] = True

after = tomlkit.dumps(doc)
if after != before:
    path.write_text(after)
