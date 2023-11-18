namespace Tests;

using OpenQA.Selenium;
using OpenQA.Selenium.Chrome;
using OpenQA.Selenium.Interactions;
using OpenQA.Selenium.Support.UI;

[TestFixture]
public class TreeBooksIndexHasAllBooks
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

    IWebElement booksIndexLink = driver.FindElement(By.LinkText("Books"));
    WebDriverWait booksIndexLinkWait = new(driver, TimeSpan.FromSeconds(2));

    booksIndexLinkWait.Until(d => booksIndexLink.Displayed);
    booksIndexLink.Click();

    IWebElement alphabeticalBooksIndexDiv = driver.FindElement(By.Id("alphabetical-books-index"));
    int alphabeticaLinksCounter = alphabeticalBooksIndexDiv.FindElements(By.TagName("a")).Count;

    IWebElement treeBooksIndexDiv = driver.FindElement(By.Id("tree-books-index"));
    int treeLinksCounter = treeBooksIndexDiv.FindElements(By.TagName("a")).Count;
    Assert.Multiple(() =>
    {
      Assert.That(treeLinksCounter, Is.Not.Zero);
      Assert.That(alphabeticaLinksCounter, Is.EqualTo(treeLinksCounter));
    });
  }
}
