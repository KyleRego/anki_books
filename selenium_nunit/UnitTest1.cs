namespace Tests;

using OpenQA.Selenium;
using OpenQA.Selenium.Chrome;

[TestFixture]
public class UnitTest1 {
  private IWebDriver driver;
  public IDictionary<string, object> Vars {get; private set;}
  private IJavaScriptExecutor js;

  [SetUp]
  public void SetUp() {
    driver = new ChromeDriver();
    js = (IJavaScriptExecutor)driver;
    Vars = new Dictionary<string, object>();
  }

  [TearDown]
  protected void TearDown() {
    driver.Quit();
  }

  [Test]
  public void Test() {
    driver.Navigate().GoToUrl("http://localhost:3000/");
    driver.Manage().Window.Size = new System.Drawing.Size(948, 1003);
    driver.FindElement(By.LinkText("Login")).Click();
  }
}
