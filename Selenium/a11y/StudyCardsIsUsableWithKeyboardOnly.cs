namespace Tests;

using Tests.Extensions;
using OpenQA.Selenium;
using OpenQA.Selenium.Chrome;
using OpenQA.Selenium.Interactions;
using OpenQA.Selenium.Support.UI;

[TestFixture]
public class StudyCards
{
  private IWebDriver driver;
  public IDictionary<string, object> Vars { get; private set; }
  private IJavaScriptExecutor js;

  [SetUp]
  public void SetUp()
  {
    driver = new ChromeDriver();
    driver.Manage().Timeouts().ImplicitWait = TimeSpan.FromSeconds(2);
    js = (IJavaScriptExecutor)driver;
    Vars = new Dictionary<string, object>();
  }

  [TearDown]
  protected void TearDown()
  {
    driver.Quit();
  }

  [Test]
  public void Test()
  {
    driver.Navigate().GoToUrl("http://localhost:3000/");
    driver.Manage().Window.Size = new System.Drawing.Size(948, 1003);
    driver.FindElement(By.LinkText("Login")).Click();
    IWebElement emailInput = driver.FindElement(By.Id("email"));
    IWebElement passwordInput = driver.FindElement(By.Id("password"));
    emailInput.SendKeys("test@example.com");
    passwordInput.SendKeys("1234asdf!!!!");
    driver.FindElement(By.Id("login")).Click();

    IWebElement studyCards = driver.FindElement(By.LinkText("Study cards"));
    WebDriverWait studyCardsWait = new(driver, TimeSpan.FromSeconds(2));

    studyCardsWait.Until(d => studyCards.Displayed);

    driver.TabNTimes(12);

    new Actions(driver)
      .KeyDown(Keys.Enter)
      .KeyUp(Keys.Enter)
      .Perform();

    IWebElement backToArticle = driver.FindElement(By.LinkText("Back to article"));
    WebDriverWait backToArticleWait = new(driver, TimeSpan.FromSeconds(2));

    backToArticleWait.Until(d => backToArticle.Displayed);

    driver.TabNTimes(8);

    new Actions(driver)
      .KeyDown(Keys.Enter)
      .KeyUp(Keys.Enter)
      .Perform();
  }
}
