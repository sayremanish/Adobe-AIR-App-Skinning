package com.kim.view
{
	import com.kim.Constants;
	import com.kim.events.FormSubmitEvent;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	import com.kim.events.ApplicationSessionEvent;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.net.URLVariables;
	
	import org.robotlegs.mvcs.Mediator;

	public class LoginFormMediator extends Mediator
	{
		[Inject]
		public var view:LoginForm;
		
		public function LoginFormMediator(form:LoginForm) {
			super();
			this.view = form;
		}
		
		override public function onRegister():void{
			this.eventMap.mapListener(view.login_btn, MouseEvent.CLICK, handleSubmitLoginForm);
			this.addContextListener(ApplicationSessionEvent.LOGGED_IN, handleLoggedIn);
			
		}
		
		private function handleSubmitLoginForm(event:MouseEvent):void {
			var email:String = view.email.text;
			var password:String = view.password.text;
			
			var params:Object = {}; // we expect a hashmap Object aka associative array
			params["username"] = email;
			params['password'] = password;

			if (email.length > 0 && password.length > 0) {
				dispatch(new FormSubmitEvent(FormSubmitEvent.SUBMIT, params));	
			}
		}
		
		private function handleLoggedIn(event:ApplicationSessionEvent):void 
		{
			this.view.visible = false;
		}

	}
}