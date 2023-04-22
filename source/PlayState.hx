package;
import flixel.FlxSprite;
import flixel.animation.FlxAnimation;
import flixel.FlxState;
import flixel.FlxG;
import flixel.util.FlxTimer;
import flixel.text.FlxText;
import flixel.math.FlxMath;
import flixel.tweens.FlxTween;
import flixel.ui.FlxButton;
import flixel.system.FlxSound;










class PlayState extends FlxState
{



   //variables for the sprites used and text
   
	var boy:FlxSprite = new FlxSprite();
	var ball:FlxSprite = new FlxSprite();
    var goal:Int = 0;
    var count:Int=0;
    var fire:FlxSprite = new FlxSprite();
    var fire1:FlxSprite = new FlxSprite();
    var fire2:FlxSprite = new FlxSprite();
    var goalText:FlxText;
    var catch1:Int = 0;
    var catchText:FlxText;
  //  var goalSound:FlxSound;

    private var tutorialModal:FlxSprite;
    private var tutorialText:FlxText;
    private var tutorialArray:Array<String>;
    private var tutorialIndex:Int;
    private var winText:FlxText;
    private var gameOver:FlxText;
    override public function create()
	{
		super.create();
//background
var background:FlxSprite = new FlxSprite();
background.loadGraphic("assets/images/bg1.jpg");
resizeImage(background,640,480,0,0);
add(background);

  
        //win text
        winText = new FlxText(0, FlxG.height / 2 - 50, FlxG.width, "You Win! \n press R to restart or Escape to exit.");
        winText.setFormat(null, 32, 0xff0000, "center");
        winText.y= 322;
        add(winText);
        winText.alpha = 0;

        //game over text
        gameOver = new FlxText(0, FlxG.height / 2 - 50, FlxG.width, "Game over \n press R to restart or Escape to exit.");
        gameOver.setFormat(null, 32, 0xff0000, "center");
        gameOver.y= 322;
        add(gameOver);
        gameOver.alpha = 0;

        // Create tutorial modal
        tutorialModal = new FlxSprite(FlxG.width/2-150, FlxG.height/2-100);
        tutorialModal.makeGraphic(300, 100, 0xAA333333);
        
        
        // Create tutorial text
        tutorialText = new FlxText(tutorialModal.x + 10, tutorialModal.y + 10, 280, "");
        tutorialText.setFormat(null, 16, 0xFFFFFFFF, "center");

        
        // Create tutorial array
        tutorialArray = [
            "The ball will randomly sent to the goal when pressing mouse left click.",
            "To start it again press right click.",
            "You can move the goalkeeper using keyboard arrows.",
            "The result will appear on the top of the screen",
            "You will win if you catch 3 out of 10 balls."
        ];
        tutorialIndex = 0;
        tutorialText.text = tutorialArray[tutorialIndex];





//fireWork to animate when win.
fire.loadGraphic("assets/images/fire.png", true,  167, 156);
fire.animation.add("fire", [0, 1, 2, 3, 4, 5, 6, 7, 8], 10, true);
fire.setPosition(26, 40);
fire1.loadGraphic("assets/images/fire.png", true,  167, 156);
fire1.animation.add("fire1", [0, 1, 2, 3, 4, 5, 6, 7, 8], 10, true);
fire1.setPosition(260, 18);
fire2.loadGraphic("assets/images/fire.png", true,  167, 156);
fire2.animation.add("fire2", [0, 1, 2, 3, 4, 5, 6, 7, 8], 10, true);
fire2.setPosition(510, 40);
    

        //show the number of goals
        goalText = new FlxText(0, 0, 200, "Goals: " + goal);
        add(goalText);
        catchText = new FlxText(100, 0, 200, "Catch: " + catch1);
        add(catchText);








       
        
        
        
        //ball
        ball.loadGraphic("assets/images/ball.png");   
        resizeImage(ball,50,50,315,420);
        add(ball);

         //goal keeper
        boy.loadGraphic("assets/images/gksprite.png",true,303,388); 
        boy.animation.add("walking", [0, 1, 2], 6,false);  
        boy.animation.add("catch", [3], 10,false); 
        boy.animation.add("stand", [1], 10,false); 
        resizeImage(boy,80,100,197,195);
        add(boy);


        add(goalText);

        add(tutorialModal);
        add(tutorialText);
        
      }


//method to change the size and the hit box of the sprite and set the position
	private function resizeImage(image:FlxSprite, w:Int,h:Int,px:Int,py:Int):Void
{
        image.height = h;
        image.width = w;
        image.scale.x = image.width / image.frameWidth;
        image.scale.y = image.height / image.frameHeight;

        image.offset.set(w, h);
        image.setPosition(px, py);
        image.updateHitbox();
}

//debug method to see the hitbox
 /*
override public function draw():Void {
    super.draw();
    rec.drawDebug();
    boy.drawDebug();
    ball.drawDebug();
}
*/

//method to change the size only
	private function imgresize(image:FlxSprite, w:Float ,h:Float):Void
{
        image.height = h;
        image.width = w;
        image.scale.x = image.width / image.frameWidth;
        image.scale.y = image.height / image.frameHeight;
        image.offset.set(w, h);
        image.updateHitbox();
}

	 override public function update(elapsed:Float)
	{
		super.update(elapsed);


if (FlxG.keys.enabled){

     
    

        if (FlxG.keys.pressed.LEFT)
        {
            if(boy.x>200)
            boy.x -= 10;
         if(!ball.alive)
            boy.animation.play("catch");
             else
            boy.animation.play("walking");
          
        }

        if (FlxG.keys.pressed.RIGHT)
        {
            if(boy.x<382)
            boy.x += 10;
            if(!ball.alive)
            boy.animation.play("catch");
             else
            boy.animation.play("walking");
           
        }

        if (FlxG.keys.pressed.UP)
        {
                trace("Mouse position: x=" + FlxG.mouse.x + " y=" + FlxG.mouse.y);
  var by:Int=195;
           var jump:Float = boy.y - 60;


        
           if(boy.y==195){

           

 var tween2:FlxTween = FlxTween.tween(boy, { x: boy.x, y: jump}, 0.1);
tween2.onComplete = function(t:flixel.tweens.FlxTween):Void { 
    var tween2:FlxTween = FlxTween.tween(boy, { x: boy.x, y: by}, 0.1);
//boy.y=by;
}
}
    if(!ball.alive)
            boy.animation.play("catch");

 else
         boy.animation.play("walking");
        }




        if (FlxG.keys.pressed.DOWN)
        {
            if(boy.y<195)
            boy.y += 2;
             if(!ball.alive)
            boy.animation.play("catch");
             else
            boy.animation.play("walking");
        }

        // Press R to restart the game

           if (FlxG.keys.pressed.R)
        {
            FlxG.resetState();
        }

        //Press escape to close it.
         if (FlxG.keys.pressed.ESCAPE)
        {
           Sys.exit(0);
        }     
}



     
 




     if (FlxG.mouse.justPressed)
        {

            //slide the toturial

            //tutorial slides when mouse pree
            tutorialIndex++;
            if (tutorialIndex < tutorialArray.length) {
                 tutorialText.text = tutorialArray[tutorialIndex];
              
            } 
            //when the array of tutorail slides ends, remove the tutorial and shot the ball
            else {
               
            remove(tutorialModal);
            remove(tutorialText);

       //if the ball in its position and alive, generate random nuber X and Y between the area of the goal
         if(ball.alive&& ball.x==315&&ball.y==420){
        //generate new position withen the goal
        var randomX:Float = Math.random() * (440 - 209 + 1) + 209;
        var randomY:Float = Math.random() * (273 - 150 + 1) + 150;
        ball.angle=0;
          
        //random number for the time that the ball will take to reach the goal(speed)
        var speed:Float = 0.05 + (0.5 - 0.09) * Math.random();

        //tween to move the ball to the new random position and totate it 360 Degree
        var tween:FlxTween = FlxTween.tween(ball, { x: randomX, y: randomY ,angle: 360 }, speed);


//change the size of the ball while tween updates
       tween.onUpdate = function(t:flixel.tweens.FlxTween):Void {
      
      // animation to make the ball smaller and rotating while on its way to goal
        while(ball.width>20){
        imgresize(ball,ball.width-=1 , ball.height-=1);

          
        }

};
        
 

//when the ball reach the destenation point
tween.onComplete = function(t:flixel.tweens.FlxTween):Void {
    //number of shots ++
count++; 

//if the ball touched the goolkeeper, play catch animation and add 1 to catch text
    if (ball.overlaps(boy))
    {
        boy.animation.play("catch");
        ball.kill();
        catch1++;
        catchText.text = "Catch1: " + catch1;
 

    }
//if the ball reached the destenation without touching the GK, then it is a gool
    else 
    {

        var tween1:FlxTween = FlxTween.tween(ball, { x: randomX, y: 280 }, 0.1);
        goal++;
        goalText.text = "Goals: " + goal;
       


    }

  

};

//when the number of shots becomes 10
if(count==9){
//if the plear catched 3 ball, he wins and the firework animation start
if(catch1>2){

        
            remove(boy);
            remove(ball); 
            remove(goalText);
            remove(catchText);
            winText.alpha = 1;
            winText.y -= 10;
          add(fire);
fire.animation.play("fire");
          add(fire1);
fire1.animation.play("fire1");
 add(fire2);
fire2.animation.play("fire2");

// goalSound.play();   
        
}
//other wise game over text will apear
else{

              
            gameOver.alpha = 1;
            gameOver.y -= 10;
}


}





}}

 }


// on right click, revive the ball and set it to the orginal position and size 

if(FlxG.mouse.justPressedRight) {

           resizeImage(ball,50,50,315,420); 
           boy.animation.play("stand");
           ball.revive();
        }










}

}





