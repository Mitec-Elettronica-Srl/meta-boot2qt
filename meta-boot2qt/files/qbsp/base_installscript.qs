// Copyright (C) 2024 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR GPL-3.0-only

function Component()
{
    // add dependency if the component is available
    if (installer.componentByName("embedded.tools"))
        component.addDependency("embedded.tools");

    if ("@TOOLCHAIN_HOST_TYPE@" == "windows" && systemInfo.kernelType !== "winnt") {
        component.enabled = false;
        component.setValue("Default", false);

        var toolchain = installer.componentByName(component.name + ".toolchain")
        if (toolchain) {
            toolchain.setValue("Default", false);
            toolchain.enabled = false;
        }
        var system = installer.componentByName(component.name + ".system")
        if (system) {
            system.setValue("Default", false);
            system.enabled = false;
        }

        QMessageBox.critical("error", "Invalid QBSP package", "The selected QBSP supports only Windows host platform.\nPlease restart the installer before continuing.");
    }
}
