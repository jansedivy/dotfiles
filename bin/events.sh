#!/bin/bash

osascript <<'END'
set theEventInfo to do shell script "/usr/local/bin/icalBuddy -n -li 1 -uid -ec 'Birthdays' -ps '/|/' eventsToday+10 | sed 's/^.*(\\(.*\\)).*uid: \\(.*\\)$/\\1|\\2/'"

set prevDelimiter to AppleScript's text item delimiters
set AppleScript's text item delimiters to {"|"}
set theEventInfos to every text item of theEventInfo
set AppleScript's text item delimiters to prevDelimiter

set theEventCalendar to first item of theEventInfos
set theEventUID to second item of theEventInfos

tell application "Calendar"
    tell calendar theEventCalendar
        set theEvent to first event whose uid is theEventUID
        set duration to (start date of theEvent) - (current date)
        return "next event in " & duration div hours & ":" & text -2 thru -1 of ("0" & (duration div minutes - (duration div hours * 60))) & return & "---" & return & summary of theEvent & return & start date of theEvent
    end tell
end tell
END
