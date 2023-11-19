namespace Tests;

using OpenQA.Selenium;
using OpenQA.Selenium.Chrome;
using OpenQA.Selenium.Interactions;
using OpenQA.Selenium.Support.UI;

using Tests.Extensions;

[TestFixture]
public class BooksIndex : AppTests
{
    private void DoTest()
    {
        driver.Navigate().GoToUrl("http://localhost:3000/");
        driver.TryToLoginWithClick("test@example.com", "1234asdf!!!!");
        GoToBooks(driver);
        CheckTwoBookIndexesEqualCounts(driver);
    }

    private static void GoToBooks(IWebDriver driver)
    {
        IWebElement booksIndexLink = driver.FindElement(By.LinkText("Books"));
        WebDriverWait booksIndexLinkWait = new(driver, TimeSpan.FromSeconds(2));

        booksIndexLinkWait.Until(d => booksIndexLink.Displayed);
        booksIndexLink.Click();
    }

    private static void CheckTwoBookIndexesEqualCounts(IWebDriver driver)
    {
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

    [Test]
    public void LargeScreenTest()
    {
        driver.Manage().Window.Size = new System.Drawing.Size(1600, 760);
        DoTest();
    }

    [Test]
    public void MediumScreenTest()
    {
        driver.Manage().Window.Size = new System.Drawing.Size(948, 1003);
        DoTest();
    }

    [Test]
    public void SmallScreenTest()
    {
        driver.Manage().Window.Size = new System.Drawing.Size(350, 600);
        DoTest();
    }
}
