import inotify.adapters

i = inotify.adapters.InotifyTree('docs/')



if __name__ == "__main__":
    for event in i.event_gen():
        # Do stuff...

        pass