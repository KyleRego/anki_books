namespace Tests;

using OpenQA.Selenium;
using OpenQA.Selenium.Chrome;

[TestFixture]
public abstract class AppTests {
  protected IWebDriver driver;
  protected IDictionary<string, object> Vars {get; private set;}
  protected IJavaScriptExecutor js;

  [SetUp]
  protected void SetUp() {
    driver = new ChromeDriver();
    driver.Manage().Timeouts().ImplicitWait = TimeSpan.FromSeconds(2);
    js = (IJavaScriptExecutor)driver;
    Vars = new Dictionary<string, object>();
  }

  [TearDown]
  protected void TearDown() {
    driver.Quit();
  }
}
