{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  floatZenPipScript = pkgs.writeTextFile {
    name = "niri-float-zen-pip";
    executable = true;
    destination = "/bin/niri-float-zen-pip";
    text = ''
      #!${pkgs.python3}/bin/python3
      import json
      import os
      import re
      import socket
      import time
      import sys

      RULES = [
          {
              "match": [
                  {
                      "app_id": r"^zen-beta$",
                      "title": r"^Picture-in-Picture$",
                  }
              ],
              "exclude": [],
          }
      ]


      def match_pattern(pattern, value):
          return re.search(pattern, value or "") is not None


      def match_window(window, pattern):
          if "title" in pattern and not match_pattern(pattern["title"], window.get("title")):
              return False
          if "app_id" in pattern and not match_pattern(pattern["app_id"], window.get("app_id")):
              return False
          return "title" in pattern or "app_id" in pattern


      def match_rule(window, rule):
          matches = rule.get("match", [])
          excludes = rule.get("exclude", [])

          if matches and not any(match_window(window, pattern) for pattern in matches):
              return False
          if any(match_window(window, pattern) for pattern in excludes):
              return False

          return bool(matches)


      def should_float(window):
          return any(match_rule(window, rule) for rule in RULES)


      def send(request):
          with socket.socket(socket.AF_UNIX) as client:
              client.connect(os.environ["NIRI_SOCKET"])
              with client.makefile("w") as file:
                  file.write(json.dumps(request))
                  file.flush()


      def float_window(window_id):
          send({"Action": {"MoveWindowToFloating": {"id": window_id}}})


      def update(window, matched_state):
          matched_before = matched_state.get(window["id"], False)
          matched_now = should_float(window)
          matched_state[window["id"]] = matched_now

          if matched_now and not matched_before:
              float_window(window["id"])


      def run_event_loop():
          matched_state = {}

          with socket.socket(socket.AF_UNIX) as client:
              client.connect(os.environ["NIRI_SOCKET"])
              with client.makefile("rw") as file:
                  file.write(json.dumps("EventStream"))
                  file.flush()
                  client.shutdown(socket.SHUT_WR)

                  for line in file:
                      event = json.loads(line)

                      if "WindowsChanged" in event:
                          next_state = {}
                          for window in event["WindowsChanged"]["windows"]:
                              update(window, matched_state)
                              next_state[window["id"]] = matched_state[window["id"]]
                          matched_state = next_state
                      elif "WindowOpenedOrChanged" in event:
                          update(event["WindowOpenedOrChanged"]["window"], matched_state)
                      elif "WindowClosed" in event:
                          matched_state.pop(event["WindowClosed"]["id"], None)

          raise RuntimeError("niri event stream ended unexpectedly")


      def main():
          if "NIRI_SOCKET" not in os.environ:
              print("NIRI_SOCKET is not set", file=sys.stderr)
              return 1

          while True:
              try:
                  run_event_loop()
              except KeyboardInterrupt:
                  return 0
              except Exception as exc:
                  print(f"niri-float-zen-pip: {exc}", file=sys.stderr, flush=True)
                  time.sleep(1)


      if __name__ == "__main__":
          raise SystemExit(main())
    '';
  };
in {
  config = mkIf config.optionalModules.linux.niri.enable {
    programs.niri.settings.spawn-at-startup = mkBefore [
      {
        command = [
          "${floatZenPipScript}/bin/niri-float-zen-pip"
        ];
      }
    ];
  };
}
