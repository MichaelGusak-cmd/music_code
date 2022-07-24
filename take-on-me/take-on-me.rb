# Waltz: 3/4

use_bpm 110 #120?
sleepTime = 0.30

#for synchronization
live_loop :wait do
  sleep 1
end

#for "x-x-x-xxx---" pattern control from Example: [Algomancer] Blockgame
define :pattern do |pattern|
  return pattern.ring.tick == "x"
end

#Drum Beat:
absolutePathToFolder = "C:\\samplePack\\wav"
kick = absolutePathToFolder + "\\drums_kick.wav"
snare = absolutePathToFolder + "\\drums_snare.wav"
live_loop :kick, sync: :wait do
  a = 5.5
  sample kick, cutoff: 130, amp: a if pattern "x---x---x---xx--"
  sleep sleepTime
end

live_loop :snare, sync: :wait do
  a = 5.5
  sample snare, cutoff: 130, amp: a if pattern "--x---x---x---x-"
  sleep sleepTime
end
#end of drum beat

#intro/buildup
intro = true
live_loop :intro, sync: :wait do
  if (intro)
    sleep sleepTime*16*2 #wait for 2 bars
    use_synth :square
    chordSpeed = 0.2
    play_pattern_timed chord(:b5, :minor), chordSpeed
    sleep sleepTime*16 - (chordSpeed*3)
    
    play :db5
    sleep sleepTime*4
    play :a4
    
    sleep sleepTime*10
    use_synth :bass_foundation
    notes = [:b2, :a2, :b3, :b2, :b2, :a2, :b3, :b3, :b2]
    times = [  1,   1,   3,   3,   1,   1,   1,   2,   3]
    2.times do
      9.times do
        tick
        play notes.look
        sleep sleepTime * times.look
      end
    end
    sleep sleepTime*2
    intro = false
  end
  stop
end

live_loop :theme, sync: :wait do
  if (!intro) #play after the intro
    use_synth :fm
    notes = [:gb5,:gb5, :d5, :b4, :b4,
             :e5, :e5, :e5,:ab5,:ab5,
             :a5, :b5, :a5, :a5, :a5,
             :e5, :d5,:gb5,:gb5,:gb5,
             :e5, :e5,:gb5, :e5,:gb5]
    times = [1,1,1,2,2,2,2,1,1,1,1,1,1,1,1,2,2,2,2,1,1,1,1,1,0]
    25.times do
      tick
      play notes.look
      sleep sleepTime * times.look
    end
  else
    sleep sleepTime*1
  end
end