// <!-- JS pour forcer la lecture du son -->
  
	document.addEventListener('DOMContentLoaded', function () {
		const audio = document.getElementById('reminderAudio');
		if (audio) {
			audio.play().catch(error => {
				console.warn("Lecture automatique bloquée par le navigateur :", error);
			});
		}
	});
