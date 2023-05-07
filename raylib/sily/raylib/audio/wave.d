module sily.raylib.audio.wave;

// // Wave/Sound loading/unloading functions
// Wave LoadWave(const char *fileName);                            // Load wave data from file
// Wave LoadWaveFromMemory(const char *fileType, const unsigned char *fileData, int dataSize); // Load wave from memory buffer, fileType refers to extension: i.e. '.wav'
// bool IsWaveReady(Wave wave);                                    // Checks if wave data is ready
// void UnloadWave(Wave wave);                                     // Unload wave data
// bool ExportWave(Wave wave, const char *fileName);               // Export wave data to file, returns true on success
// bool ExportWaveAsCode(Wave wave, const char *fileName);         // Export wave sample data to code (.h), returns true on success
// Wave WaveCopy(Wave wave);                                       // Copy a wave to a new wave
// void WaveCrop(Wave *wave, int initSample, int finalSample);     // Crop a wave to defined samples range
// void WaveFormat(Wave *wave, int sampleRate, int sampleSize, int channels); // Convert wave data to desired format
// float *LoadWaveSamples(Wave wave);                              // Load samples data from wave as a 32bit float data array
// void UnloadWaveSamples(float *samples);                         // Unload samples data loaded with LoadWaveSamples()
