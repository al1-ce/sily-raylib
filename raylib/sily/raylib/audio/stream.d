module sily.raylib.audio.stream;

// // AudioStream management functions
// AudioStream LoadAudioStream(unsigned int sampleRate, unsigned int sampleSize, unsigned int channels); // Load audio stream (to stream raw audio pcm data)
// bool IsAudioStreamReady(AudioStream stream);                    // Checks if an audio stream is ready
// void UnloadAudioStream(AudioStream stream);                     // Unload audio stream and free memory
// void UpdateAudioStream(AudioStream stream, const void *data, int frameCount); // Update audio stream buffers with data
// bool IsAudioStreamProcessed(AudioStream stream);                // Check if any audio stream buffers requires refill
// void PlayAudioStream(AudioStream stream);                       // Play audio stream
// void PauseAudioStream(AudioStream stream);                      // Pause audio stream
// void ResumeAudioStream(AudioStream stream);                     // Resume audio stream
// bool IsAudioStreamPlaying(AudioStream stream);                  // Check if audio stream is playing
// void StopAudioStream(AudioStream stream);                       // Stop audio stream
// void SetAudioStreamVolume(AudioStream stream, float volume);    // Set volume for audio stream (1.0 is max level)
// void SetAudioStreamPitch(AudioStream stream, float pitch);      // Set pitch for audio stream (1.0 is base level)
// void SetAudioStreamPan(AudioStream stream, float pan);          // Set pan for audio stream (0.5 is centered)
// void SetAudioStreamBufferSizeDefault(int size);                 // Default size for new audio streams
// void SetAudioStreamCallback(AudioStream stream, AudioCallback callback);  // Audio thread callback to request new data
