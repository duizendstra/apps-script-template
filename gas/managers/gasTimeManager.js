/**
 * @fileoverview gasTimeManager.js - Manages time-related operations, including checking available time and resetting the start time.
 * @module gasTimeManager
 * @description This module provides a factory function to create a time manager that tracks and manages available time for operations, especially useful in environments with execution time limits like Google Apps Script.
 */
/**
 * Factory function for creating a time manager instance.
 * @param {Object} config - Configuration object.
 * @param {Object} config.logManager - Logger object for debugging.
 * @param {number} config.availableTime - Available time in milliseconds.
 * @returns {Object} - An object with the methods `hasEnoughTime` and `resetStartTime`.
 */
const gasTimeManager = (config) => {
  const { logManager, availableTime } = config;
  let startTime = Date.now(); // Initialize startTime
  
   /**
   * Calculates the current time status.
   * @returns {{elapsedTime: number, remainingTime: number}}
   * @private
   */
    const _getTimeStatus = () => {
        const elapsedTime = Date.now() - startTime;
        const remainingTime = availableTime - elapsedTime;
        return { elapsedTime, remainingTime };
    };
  
  /**
   * Checks if there is enough time left for an operation.
   * @param {number} operationTime - The estimated time required for the operation.
   * @returns {boolean} - True if there is enough time, false otherwise.
   */
    const hasEnoughTime = (operationTime) => {
        const { remainingTime } = _getTimeStatus();
        return remainingTime >= operationTime;
    };
  
    /**
     * Resets the timer's start point to the current time.
     */
    const resetStartTime = () => {
      startTime = Date.now();
    };
  
    return {
      hasEnoughTime,
      resetStartTime,
    };
  };
  
  // No module.exports needed, as this will be globally available.