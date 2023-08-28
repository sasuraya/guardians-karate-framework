package api.utility.date;

import com.intuit.karate.junit5.Karate;

public class TestRunner {
	
	//By adding this we are annotation karate
	@Karate.Test
	public Karate runTest() {
		//address for our feature files and tag
		return Karate.run("classpath:features")
				.tags("Smoke");
				 
		//return Karate.run("classpath:features").tags("@Regression,@Smoke");
	}
}
