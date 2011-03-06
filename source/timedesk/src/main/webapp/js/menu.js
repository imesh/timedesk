/* 
Simple JQuery menu.
Copyright 2007-2010 by Marco van Hylckama Vlieg

Web: http://www.i-marco.nl/weblog/
Email: marco@i-marco.nl
*/

var jcode = jQuery.noConflict(true); 
jcode.fn.initMenu = function() {  
    return this.each(function(){
        var theMenu = jcode(this).get(0);
        jcode('.acitem', this).hide();
        jcode('li.expand > .acitem', this).show();
        jcode('li.expand > .acitem', this).prev().addClass('active');
        jcode('li a', this).click(
            function(e) {
                e.stopImmediatePropagation();
                var theElement = jcode(this).next();
                var parent = this.parentNode.parentNode;
                if(jcode(parent).hasClass('noaccordion')) {
                    if(theElement[0] === undefined) {
                        window.location.href = this.href;
                    }
                    jcode(theElement).slideToggle('normal', function() {
                        if (jcode(this).is(':visible')) {
                            jcode(this).prev().addClass('active');
                        }
                        else {
                            jcode(this).prev().removeClass('active');
                        }    
                    });
                    return false;
                }
                else {
                    if(theElement.hasClass('acitem') && theElement.is(':visible')) {
                        if(jcode(parent).hasClass('collapsible')) {
                            jcode('.acitem:visible', parent).first().slideUp('normal', 
                            function() {
                                jcode(this).prev().removeClass('active');
                            }
                        );
                        return false;  
                    }
                    return false;
                }
                if(theElement.hasClass('acitem') && !theElement.is(':visible')) {         
                    jcode('.acitem:visible', parent).first().slideUp('normal', function() {
                        jcode(this).prev().removeClass('active');
                    });
                    theElement.slideDown('normal', function() {
                        jcode(this).prev().addClass('active');
                    });
                    return false;
                }
            }
        }
    );
});
};

jcode(document).ready(function() {jcode('.menu').initMenu();});