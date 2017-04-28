>背景：Spring Boot 集成servlet，发布为可直接运行的war包，方便后续打包为docker镜像。

#1、build.gradle 配置
注意，加入了war插件，在依赖中加入了jstl、tomcat-embed-jasper，这样才能运行jsp页面。
```
buildscript {
    ext {
        springBootVersion = '1.5.3.RELEASE'
    }
    repositories {
        maven { url "http://maven.aliyun.com/nexus/content/groups/public/" }
    }
    dependencies {
        classpath("org.springframework.boot:spring-boot-gradle-plugin:${springBootVersion}")
    }
}
apply plugin: 'java'
apply plugin: 'idea'
apply plugin: 'org.springframework.boot'
apply plugin: 'war'

version = '0.0.1-SNAPSHOT'
sourceCompatibility = 1.8
repositories {
    maven { url "http://maven.aliyun.com/nexus/content/groups/public/" }
}
dependencies {
    compile 'jstl:jstl:1.2'
    compile 'org.apache.tomcat.embed:tomcat-embed-jasper'
    compile('org.springframework.boot:spring-boot-starter-web')
    testCompile('org.springframework.boot:spring-boot-starter-test')
}
```

#2、spring boot 入口文件配置
注意：继承`SpringBootServletInitializer`,开启`@ServletComponentScan`
```
@SpringBootApplication
@ServletComponentScan
public class DemoApplication extends SpringBootServletInitializer {
    @Override
    protected SpringApplicationBuilder configure(SpringApplicationBuilder builder) {
        return builder.sources(DemoApplication.class);
    }
    public static void main(String[] args) {
        SpringApplication.run(DemoApplication.class, args);
    }
}
```
#3、servlet/jsp 的正确姿势

![文件布放图](http://upload-images.jianshu.io/upload_images/535124-9e0d5fb13f61b830.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

##3.1、servlet
注意：使用了`@WebServlet`配置页面访问地址，访问jsp页面需要使用完整的相对路径`/WEB-INF/jsp/index.jsp`
```
@WebServlet( urlPatterns = {"/index"})
public class Index extends HttpServlet {
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        doGet(req, resp);
    }
    public void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/jsp/index.jsp").forward(request, response);
    }
}
```


##3.2、controller方式使用jsp
注意：配合application.properties配置，可以使用简化的jsp路径
###①application.properties配置
```
spring.mvc.view.prefix=/WEB-INF/jsp/
spring.mvc.view.suffix=.jsp
```
###②controller编写
```
@Controller
    public class HelloController {
        @RequestMapping("/index1")
        public ModelAndView index(ModelAndView view) {
            view.setViewName("index");
            return view;
        }
    }
```



#4、运行方法
右键入口文件直接运行
bootRun
执行gradle build，java -jar xxx.war
