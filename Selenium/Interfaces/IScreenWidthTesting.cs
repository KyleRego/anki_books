namespace Tests.Interfaces;

public interface IScreenWidthTesting
{
  [Test]
  public void LargeScreenTest();

  [Test]
  public void MediumScreenTest();

  [Test]
  public void SmallScreenTest();
}