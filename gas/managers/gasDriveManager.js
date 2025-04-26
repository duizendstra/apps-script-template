/**
 * @fileoverview gasDriveManager.js - Manages interactions with Google Drive.
 * @module gasDriveManager
 * @description This module provides functionalities to interact with Google Drive, such as retrieving all files and folders.
 */

/**
 * @requires gasErrorManager
 * @requires gasTimeManager
 */

// Import the gasErrorManager module for handling errors.
const gasErrorManager = require('./gasErrorManager');
// Import the gasTimeManager module for tracking time.
const gasTimeManager = require('./gasTimeManager');

/**
 * Manages interactions with Google Drive.
 * This class provides methods to access and manage files and folders in Google Drive.
 * @class
 */
class GasDriveManager {
  /**
   * Retrieves all files and folders from Google Drive.
   * This function fetches both files and folders from the root of the Google Drive.
   * @returns {Array} An array of files and folders.
   * Each object in the array contains details like id, name, type (file/folder), 
   * MIME type (for files), creation date, last updated date, and URL.
   * @throws {Error} Throws an error if there is an issue accessing Drive.
   * @memberof GasDriveManager
   */
  getAllFiles() {
    try {
      // Start the timer to track the execution time of this function.
      gasTimeManager.startTimer('getAllFiles');
      // Initialize an empty array to store file and folder data.
      const files = [];
      // Get all folders in the root of the Drive.
      const folders = DriveApp.getFolders();
       // Get the root folder of the Drive.
      const root = DriveApp.getRootFolder();
      // Get all files in the root folder.
      const rootFiles = root.getFiles();

      while (rootFiles.hasNext()) {
        const file = rootFiles.next();
        files.push({
          id: file.getId(),
          name: file.getName(),
          type: 'file',
          mimeType: file.getMimeType(),
          dateCreated: file.getDateCreated(),
          lastUpdated: file.getLastUpdated(),
          url: file.getUrl(),
        });
      }
      while (folders.hasNext()) {
        const folder = folders.next();
        files.push({
          id: folder.getId(),
          name: folder.getName(),
          type: 'folder',
          dateCreated: folder.getDateCreated(),
          lastUpdated: folder.getLastUpdated(),
          url: folder.getUrl(),
        });
      }
      // Stop the timer and log the elapsed time.
      gasTimeManager.stopTimer('getAllFiles');
      // Return the collected files and folders data.
      return files;
    } catch (error) {
       // Log the error using gasErrorManager.
      gasErrorManager.logError(error, 'getAllFiles');
      // Re-throw the error with a descriptive message.
      throw new Error(`Error in getAllFiles: ${error.message}`);
    }
  }
}
// Export an instance of GasDriveManager for use in other modules.
module.exports = new GasDriveManager();