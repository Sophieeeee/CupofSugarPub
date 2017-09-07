package server;

import java.io.IOException;
import java.util.Vector;

import javax.websocket.OnClose;
import javax.websocket.OnError;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.ServerEndpoint;

@ServerEndpoint(value = "/cupofsugar")
public class WebSocketEndpoint {

	private static Vector<Session> sessionVector = new Vector<Session>();

	// User connects
	@OnOpen
	public void open(Session session) {
		System.out.println("opening websocket");
		sessionVector.add(session);
	}

	// user clicks
	@OnMessage
	public void onMessage(String message, Session session) {
		System.out.println("message: " + message);

		try {
			for (Session s : sessionVector) {
				s.getBasicRemote().sendText(message);
			}

		} catch (IOException ioe) {
			System.out.println("ioe: " + ioe.getMessage());
		}

	}

	// User closes
	@OnClose
	public void onClose(Session session) {
		System.out.println("closing websocket");
		sessionVector.remove(session);
	}

	// Any sort of error
	@OnError
	public void onError(Throwable error) {
		System.out.println(error.getMessage());

	}

}