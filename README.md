# Windows 10 updates


A PowerShell script to make Windows 10 ask before downloading new updates.

The `variables` script is a helper script only. It contains variables and functions used by the `init` script.


## Running:
Before the scripts can be run, PowerShell's Execution Policy needs to be changed to `RemoteSigned` or `Unrestricted`.
1. Download or clone the repository.
1. Disconnect from the internet and check for updates (Settings -> Update & Security -> Windows Update).
1. Open PowerShell with Administrator privileges and run one of the following commands:
   * `Set-ExecutionPolicy RemoteSigned`
   * `Set-ExecutionPolicy Unrestricted`
1. Open the `init.ps1` script in PowerShell Integrated Scripting Environment (ISE) and check the settings that will be applied. Comment out the settings you do not wish to be applied.
1. Run the script with Administrator privileges.
1. Reboot the computer to finalise the changes.
1. Still disconnected from the internet, check for updates again.
1. You should see ` Some settings are managed by your organisation ` at the top of the updates window.
1. Reconnect to the internet and allow any updates to complete.

## License:
GNU General Public License v3

You may copy, distribute, and modify the software as long as you track the changes in the source files. Any modifications must also be made available under the GPL-3.

The software is provided "as is", without warranty of any kind, express or implied, including but not limited to the warranty of fitness for a particular purpose. In no event shall the authors or copyright holders be liable for any claim, damages or other liability, whether in an action of contract or otherwise, arising from, out of, or in connection with the software or the use or other dealings in the software.

See the LICENSE.md file for more information
