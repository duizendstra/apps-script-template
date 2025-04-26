function listAllDriveFiles() {
  let files = DriveApp.getFiles();
  while (files.hasNext()) {
    let file = files.next();
    Logger.log('Name: ' + file.getName() + ', ID: ' + file.getId());
  }
}