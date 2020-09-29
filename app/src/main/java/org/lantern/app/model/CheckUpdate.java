package org.lantern.app.model;

public class CheckUpdate {

    private boolean userInitiated;

    public CheckUpdate(final boolean userInitiated) {
        this.userInitiated = userInitiated;
    }

    public boolean getUserInitiated() {
        return userInitiated;
    }
}
