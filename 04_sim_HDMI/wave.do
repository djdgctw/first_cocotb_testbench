onerror {resume}
quietly WaveActivateNextPane {} 0
log -r /*
run -all
quit