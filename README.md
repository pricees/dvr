# DVR

DVR interface for fun

## Usage

This is an exploratory design of a DVR system

## Background Information

The DVR takes input from the user for recording priorities, and schedule, and
matches this against the tv schedule.

Its a relatively naive system, if there are tuners that are available for
recording, it records. 

## Extras

There are a number of challenges with mapping this domain, that I have tried to
take into account.

- Size of dvr disk and remaining space
- Change the number of tuners on the dvr
- Considering that priority may be taken into account in the future
- Taking into account that a user may want to halt! one recording, and resume!
  it later
- The "smart" recording so that if only a partial recording is downloaded, the
  device will leave enough space to get the full recording next pass
- Checking for updates of the minute, given that broadcasters offset their start
  times to attempt to fool DVRs

```
rake        # run test suite
```

```
ruby examples/driver.rb  # run example 
```



