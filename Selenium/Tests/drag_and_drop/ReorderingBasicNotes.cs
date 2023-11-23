namespace Tests;

using System.Collections.ObjectModel;
using OpenQA.Selenium;
using OpenQA.Selenium.Chrome;
using OpenQA.Selenium.Interactions;
using Tests.Extensions;
using Tests.Interfaces;

[TestFixture]
public class ReorderingBasicNotes : AppTests
{
    [Test]
    public void Test()
    {
        driver.Navigate().GoToUrl("http://localhost:3000/");
        driver.Manage().Window.Size = new System.Drawing.Size(948, 1003);
        driver.TryToLoginWithClick("test@example.com", "1234asdf!!!!");
        driver.PressTabUntilOnText("Read");
        driver.PressEnter();
        driver.PauseXSeconds(5);
        ReadOnlyCollection<IWebElement> basicNotes = driver.FindElements(By.CssSelector(".draggable-div-of-note"));
        IWebElement draggable = basicNotes[0];
        IWebElement droppable = basicNotes[1];
        int draggableX = draggable.Location.X;
        int draggableY = draggable.Location.Y;
        int dropzoneX = droppable.Location.X;
        int dropzoneY = droppable.Location.Y;

        int xDragOffset = dropzoneX - draggableX;
        int yDragOffset = dropzoneY - draggableY;

        draggable.Click();
        driver.PauseXSeconds(0.2);
        droppable.Click();
        driver.PauseXSeconds(0.2);
        new Actions(driver)
          .MoveToElement(draggable)
          .Pause(TimeSpan.FromSeconds(0.25))
          .ClickAndHold()
          .Pause(TimeSpan.FromSeconds(0.25))
          .MoveByOffset(xDragOffset, 5 * yDragOffset)
          .Pause(TimeSpan.FromSeconds(0.25))
          .Release()
          .Perform();
    }
}
