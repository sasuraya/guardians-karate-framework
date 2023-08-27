package api.utility.date;

import com.intuit.karate.junit5.Karate;

public class TestRunner {
	
	// by adding this we are anotation karate
	@Karate.Test
	public Karate runTest() {
		//address for our feature files and tag
		return Karate.run("classpath:features")
				.tags("@Regression");
	// if you want to run regression and smoke togeter			 
	//return Karate.run("classpath:features").tags("@Regression,@Smoke");
	}
}

// you can open pom and right click and run it as maven clean 
// it will run and clean the target folder
// u can also run maven test in pom
//i add this depindicy to run my project with maven
//<!-- Adding Build Plagins to this Project -->
//<build>
//	<plugins>
//		<plugin>
//			<artifactId>maven-compiler-plugin</artifactId>
//			<version>3.7.0</version>
//		</plugin>
//		<plugin>
//			<groupId>org.apache.maven.plugins</groupId>
//			<artifactId>maven-surefire-plugin</artifactId>
//			<version>2.22.2</version>
//			<configuration>
//				<includes>
//					<include>TestRunner.java</include>
//				</includes>
//			</configuration>
//		</plugin>
//	</plugins>
//</build>
//</project>