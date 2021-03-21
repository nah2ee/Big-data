package com.koreait;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.util.List;

import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeDriver;

public class Banapresso {

	public static void main(String[] args) {
		String DRIVER_ID = "webdriver.chrome.driver";
		String DRIVER_PATH = "D:/04. Code/Jsp/exe/chromedriver_win32/chromedriver.exe";

		System.setProperty(DRIVER_ID, DRIVER_PATH);
		WebDriver driver = new ChromeDriver();
		// ========== 크롬 드라이브 연결

		Connection conn = null;
		PreparedStatement pstmt = null;

		String sql = "";
		String url = "jdbc:mysql://localhost:3306/banapresso";
		String uid = "root";
		String upw = "1234";
		// ========== mySql 연결

		String base_url = "https://www.banapresso.com/store";

		try {
			driver.get(base_url);
			Thread.sleep(2000); // 시작시 2초 지연

			int pageNum = 2;
			String sto_name = null; // 지점명 저장
			String sto_address = null; // 주소 저장

			while (true) {
				List<WebElement> store = driver.findElements(By.cssSelector(".store_name_map > i")); // 지점명 리스트 저장
				List<WebElement> address = driver.findElements(By.cssSelector(".store_name_map > i + span")); // 주소 리스트 저장

				try {
					Class.forName("com.mysql.jdbc.Driver");
					conn = DriverManager.getConnection(url, uid, upw);

					if (conn != null) {
						sql = "insert into tb_store(sto_name, sto_address) values (?, ?)";

						pstmt = conn.prepareStatement(sql);

//						for (WebElement st : store) { sto_name = st.getText(); System.out.println(sto_name); pstmt.setString(1, sto_name); }

//						for (WebElement ad : address) { sto_address = ad.getText(); System.out.println(sto_address); pstmt.setString(2, sto_address); }

						for (int i = 0; i <= store.size(); i++) {
							sto_name = store.get(i).getText(); // st
							sto_address = address.get(i).getText(); // ad

							System.out.println(sto_name);
							pstmt.setString(1, sto_name);
							System.out.println(sto_address);
							pstmt.setString(2, sto_address);
							pstmt.executeUpdate();
						}
					}
				} catch (Exception e) {
					e.printStackTrace();
				}

				if (pageNum <= 5) {
					WebElement Nextpage = driver.findElement(By.cssSelector(".pagination > ul > li:nth-child(" + pageNum + ")"));
					Nextpage.click();
					Thread.sleep(2000);
					pageNum++;
				} else {
					WebElement Nexttab = driver.findElement(By.cssSelector(".store_list_box > .pagination > .btn_page_next > a"));
					Nexttab.click();
					Thread.sleep(2000);
					pageNum = 2;
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		driver.close();

	} // main 종료
}
