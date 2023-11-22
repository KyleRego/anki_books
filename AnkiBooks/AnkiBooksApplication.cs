using AnkiBooks.Database;

namespace AnkiBooks;

/// <summary>
/// Has static methods for configuring WebApplicationBuilder (services)
/// and WebApplication (swagger, middleware, routing).
/// </summary>
public class AnkiBooksApplication
{
    static readonly private string MyAllowSpecificOrigins = "_myAllowSpecificOrigins";

    public static WebApplicationBuilder ApplicationBuilder()
    {
        WebApplicationBuilder builder = WebApplication.CreateBuilder();

        builder.Services.AddCors(options =>
        {
            options.AddPolicy(name: MyAllowSpecificOrigins,
                policy =>
                {
                    policy.WithOrigins("https://localhost:44454")
                        .AllowAnyMethod()
                        .AllowAnyHeader()
                        .AllowCredentials();
                });
        });

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

        app.UseCors(MyAllowSpecificOrigins);

        app.MapControllerRoute(
            name: "default",
            pattern: "{controller}/{action=Index}/{id?}");

        app.MapFallbackToFile("index.html");
        return app;
    }
}