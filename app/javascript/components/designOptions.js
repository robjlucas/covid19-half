//document.onload = function() {

	function designOptions() {

		console.log('Loadinig,,,,,');
		var classOpts = ['opt1', 'opt2', 'opt3'],
			i = 0;

		document.onkeydown = function(event) {
			target = document.getElementById('body'),
			console.log('i', i);
			console.log('target', target);
			switch (event.keyCode) {
			   case 39:
					// Right key pressed
					//target.classList.replace(classOpts[i], classOpts[i+1]);
					i < classOpts.length - 1 ? i++ : i = 0;
					target.setAttribute('class', classOpts[i]);
				    break;
			   case 37:
					// Left key pressed
					//target.classList.replace(classOpts[i], classOpts[i-1]);
					i > 0 ? i-- : i = classOpts.length - 1;
					target.setAttribute('class', classOpts[i]);
				    break;
			}
		}
	}
	designOptions();
	
//}
