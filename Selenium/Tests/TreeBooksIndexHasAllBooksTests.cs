namespace Tests;

using OpenQA.Selenium;
using OpenQA.Selenium.Chrome;
using OpenQA.Selenium.Interactions;
using OpenQA.Selenium.Support.UI;

using Tests.Extensions;

[TestFixture]
public class BooksIndex : AppTests
{
  [Test]
  public void Test()
  {
    driver.Navigate().GoToUrl("http://localhost:3000/");
    driver.Manage().Window.Size = new System.Drawing.Size(948, 1003);
    driver.TryToLoginWithClick("test@example.com", "1234asdf!!!!");

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
    driver.PauseXSeconds(5);
  }
}
