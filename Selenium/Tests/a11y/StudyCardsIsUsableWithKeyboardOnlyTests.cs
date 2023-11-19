namespace Tests;

using OpenQA.Selenium;
using OpenQA.Selenium.Chrome;
using OpenQA.Selenium.Interactions;
using OpenQA.Selenium.Support.UI;

using Tests.Extensions;

[TestFixture]
public class StudyCards : AppTests
{
  [Test]
  public void Test()
  {
    driver.Navigate().GoToUrl("http://localhost:3000/");
    driver.Manage().Window.Size = new System.Drawing.Size(948, 1003);
    driver.TryToLoginWithClick("test@example.com", "1234asdf!!!!");

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
