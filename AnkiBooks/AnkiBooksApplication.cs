using AnkiBooks.Database;

namespace AnkiBooks;

/// <summary>
/// Has static methods for configuring WebApplicationBuilder (services)
/// and WebApplication (swagger, middleware, routing).
/// </summary>
public class AnkiBooksApplication
{
    public static WebApplicationBuilder ApplicationBuilder()
    {
        WebApplicationBuilder builder = WebApplication.CreateBuilder();

        builder.Services.AddControllersWithViews();
        builder.Services.AddSwaggerGen();
        builder.Services.AddDbContext<AnkiBooksDatabase>();

        return builder;
    }

    public static WebApplication Application(WebApplicationBuilder builder)
    {
        WebApplication app = builder.Build();

        if (!app.Environment.IsDevelopment())
        {
            app.UseHsts();
        }

        app.UseSwagger();
        app.UseSwaggerUI();

        app.UseHttpsRedirection();
        app.UseStaticFiles();
        app.UseRouting();

        app.MapControllerRoute(
            name: "default",
            pattern: "{controller}/{action=Index}/{id?}");

        app.MapFallbackToFile("index.html");
        return app;
    }
}