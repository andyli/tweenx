import nme.display.GradientType;
import nme.display.InterpolationMethod;
import nme.display.SpreadMethod;
import nme.display.Sprite;
import nme.display.Shape;
import nme.display.StageScaleMode;
import nme.geom.Matrix;
import nme.geom.Point;
import nme.Lib;
import tweenx909.rule.HsvX;

import tweenx909.TweenX;
import tweenx909.EaseX;
using tweenx909.ChainX;

class Main extends Sprite {
	static public inline var CELL_SIZE = 20;
	
	public function new() {
		super();
		Lib.current.stage.scaleMode = StageScaleMode.SHOW_ALL;
		
		//Draw background
		graphics.lineStyle( 1, 0xEEEEEE );
		var end = CELL_SIZE * 20;
		for ( i in 0...21 ) {
			var p = i * CELL_SIZE;
			graphics.moveTo( 0, p );
			graphics.lineTo( end, p );
			graphics.moveTo( p, 0 );
			graphics.lineTo( p, end );
		}
		
		var dump = TweenX.dumpDefaults();
		
		//Make square
		var square = new GradientSquare(  
			[ 0x2C3E50, 0xE74C3C,	0xECF0F1,	 ],
			[ 0, 		0.5,		1,			 ],
			[ 0, 		64, 		255,	 	 ] 
		);
		addChild( square );
		square.x = square.y = CELL_SIZE * 6;
		
		//Tween!!
		TweenX.to( square, 
				{
					colors:[ HsvX.of(0x08A689),		HsvX.of(0xC7D93D),		HsvX.of(0xE9F2A0) 	],
					alphas:[ 1, 				 	0, 				 		0.5, 				],
					ratios:[ 0, 				 	192, 				 	255, 				]
				}).time( 2 ).ease( EaseX.expoInOut ).onUpdate( square.update );
				
	}
}

private class GradientSquare extends Shape{
	public var colors:Array<UInt>;
	public var alphas:Array<Float>;
	public var ratios:Array<Float>;
	
	public function new( colors:Array<UInt>, alphas:Array<Float>, ratios:Array<Float> ) {
		super();
		this.colors = colors;
		this.alphas = alphas;
		this.ratios = ratios;
		update();
	}
	
	public function update() {
		var size = Main.CELL_SIZE * 8;
		var mtr = new Matrix();
		mtr.createGradientBox( size, size, 0 );
		graphics.clear();
		graphics.beginGradientFill( GradientType.RADIAL, colors, alphas, ratios, mtr, null, InterpolationMethod.RGB );
		graphics.drawRect( 0, 0, size, size );
	}
}