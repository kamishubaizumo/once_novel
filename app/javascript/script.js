let textareaTab = {};
(function() {
    textareaTab.setEvent = function() {
        console.log("set textarea tab event.");
        var textareas = document.querySelectorAll('textarea');
        for (var ti = 0; ti < textareas.length; ti++) {
            textareas[ti].addEventListener('keydown', function(e) {
                if (e.keyCode === 9) {
                    e.preventDefault();
                    var isShift = e.shiftKey;
                    var elm = e.target;
                    var txt = elm.value;
                    var slct = {
                        left: elm.selectionStart,
                        right: elm.selectionEnd,
                    };
                    if (slct.left == slct.right && !isShift) {
                        elm.value = txt.substr(0, slct.left) + '\t' + txt.substr(slct.left, txt.length);
                        slct.left++;
                        slct.right++;
                    } else {
                        var lineStart = txt.substr(0, slct.left).split('\n').length - 1;
                        var lineEnd = txt.substr(0, slct.right).split('\n').length - 1;
                        var lines = txt.split('\n');
                        for (var i = lineStart; i <= lineEnd; i++) {
                            if (!isShift) {
                                lines[i] = '\t' + lines[i];
                                if (i == lineStart) {
                                    slct.left++;
                                }
                                slct.right++;
                            } else if (lines[i].substr(0, 1) == '\t') {
                                lines[i] = lines[i].substr(1);
                                if(i == lineStart) {
                                    slct.left--;
                                }
                                slct.right--;
                            }
                        }
                        elm.value = lines.join('\n');
                    }
                    elm.setSelectionRange(slct.left, slct.right);
                    return false;
                }
            })
        }
    }
})();

export default textareaTab;





