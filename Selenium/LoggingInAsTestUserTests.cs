namespace Tests;

using OpenQA.Selenium;
using OpenQA.Selenium.Chrome;

[TestFixture]
public class LoggingInAsTestUser {
  private IWebDriver driver;
  public IDictionary<string, object> Vars {get; private set;}
  private IJavaScriptExecutor js;

  [SetUp]
  public void SetUp() {
    driver = new ChromeDriver();
    driver.Manage().Timeouts().ImplicitWait = TimeSpan.FromSeconds(2);
    js = (IJavaScriptExecutor)driver;
    Vars = new Dictionary<string, object>();
  }

  [TearDown]
  protected void TearDown() {
    driver.Quit();
  }

  [Test]
  public void Test() {
    driver.Navigate().GoToUrl("http://ankibooks.io/");
    driver.Manage().Window.Size = new System.Drawing.Size(948, 1003);
    driver.FindElement(By.LinkText("Login")).Click();
    IWebElement emailInput = driver.FindElement(By.Id("email"));
    IWebElement passwordInput = driver.FindElement(By.Id("password"));
    emailInput.SendKeys("test@example.com");
    passwordInput.SendKeys("1234asdf!!!!");
    driver.FindElement(By.Id("login")).Click();
  }
}
