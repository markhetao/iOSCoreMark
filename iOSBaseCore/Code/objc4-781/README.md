# OC底层原理二：objc4-781编译环境（真实的底层世界）

> [OC底层原理 学习大纲](https://www.jianshu.com/p/9e19354c0266)

后续探索，基于`macOS 10.15.1`版本发布的`objc4-781`源码。
但是源码无法直接运行和编译，我们需要搭建可编译环境。

> 如果想走 [快捷通道](https://github.com/LGCooci/objc4_debug/tree/master)，可下载Cooci老师的`可编译源码` :  运行`objc4-781`版本

# 开发环境
- macOS 10.15.6
- Xcode 11.7 
- objc4-781

# 下载资源

#### 1. objc4-781源码
下载方法一： 
苹果开源源码汇总: https://opensource.apple.com，在`macOS -> 10.15.1`版本中，搜索`objc4`，直接下载` objc4-781`。

下载方法二：
直接地址： https://opensource.apple.com/tarballs/，搜索`objc4`。进入，找到` objc4-781`并下载。

#### 2. 依赖文件
![image.png](https://upload-images.jianshu.io/upload_images/12857030-9c96123db5b14e72.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

在[苹果开源源码页面](https://opensource.apple.com)，除了`lauchd-106.10`需要在`macOS -> 10.4.4.x86`版本中下载。 其余均可在`macOS -> 10.15.1`版本中搜索到。

#### 3. 编译源码

## 这是个痛苦的过程，得不断调试和修改源码问题。

打开`objc.xcodeproj`,选中`objc`target，开始编译：
![image.png](https://upload-images.jianshu.io/upload_images/12857030-aa9f701470349708.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)


#### 问题一： `unable to find sdk 'macosx.internal'`

![unable to find sdk macosx.internal.png](https://upload-images.jianshu.io/upload_images/12857030-fffb07dfe0362b79.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

处理: 
1. `target -> objc -> build Setings ->Architectures` 的  `BaseSDK` 选中` macOS 10.15`
2. `target -> objc-trampolines -> build Setings -> Architectures` 的  `BaseSDK`选中 `macOS 10.15`

![image.png](https://upload-images.jianshu.io/upload_images/12857030-b6ea475022299d19.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

#### 问题二：一系列缺失文件的问题
##### 1.  'sys/reason.h' file not found

![image.png](https://upload-images.jianshu.io/upload_images/12857030-76779e1cf4b77312.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

- 在下载的依赖文件夹中，找到文件：`xnu-6153.41.3 -> bsd -> sys -> reason.h`

- 在`objc4-781`的根目录下新建`HTCommon`文件夹，在HTCommon中创建`sys`文件夹，将`reason.h`文件拷贝到`sys`文件夹中

![image.png](https://upload-images.jianshu.io/upload_images/12857030-fbf3a26bef239cf1.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

- 配置`文件索引`路径: 
`target`->`objc`->`Build Settings` 搜索 `header_search Paths`, 添加`$(SRCROOT)/HTCommon`

![image.png](https://upload-images.jianshu.io/upload_images/12857030-87eccf60defe5928.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

##### 2.'mach-o/dyld_priv.h' file not found

![image.png](https://upload-images.jianshu.io/upload_images/12857030-ff7ce96d40036067.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

- 在`HTCommon`文件夹中，创建`march-o`文件夹
- 在下载的依赖文件夹中，找到文件：`dyld-733.6 -> include -> mach-o -> dyld_priv.h`,复制到`HTCommon/march-o`文件夹中

![image.png](https://upload-images.jianshu.io/upload_images/12857030-62cb7ad15daf1466.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)


##### 3. 'os/lock_private.h' file not found

![image.png](https://upload-images.jianshu.io/upload_images/12857030-ed764721593f62ad.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
- 在`HTCommon`文件夹中，创建`os`文件夹
- 在下载的依赖文件中，找到文件: `libplatform-220 --> private --> os --> lock_private.h 和 base_private.h`，复制到`HTCommon/os`文件夹中

##### 4. dyld_priv.h 报了一堆 Expected ',' 错误

![image.png](https://upload-images.jianshu.io/upload_images/12857030-245f46afc1f8ec23.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

- 我们暂时直接移除`bridgeos(3.0)`，世界瞬间安静了

##### 5. lock_private.h 报 Expected ',' 错误

![image.png](https://upload-images.jianshu.io/upload_images/12857030-8436a18197f8dd53.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

- 继续移除报错的`移除`bridgeos(3.0)`

##### 6. 'pthread/tsd_private.h' file not found

![image.png](https://upload-images.jianshu.io/upload_images/12857030-9b0524f1d6a398dc.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

- 在`HTCommon`文件夹中，创建`pthread`文件夹
- 找到文件：`libpthread-416.40.3 --> private --> tsd_private.h 和 spinlock_private.h`,复制到`HTCommon/pthread`文件夹中

##### 7. 'System/machine/cpu_capabilities.h' file not found

![image.png](https://upload-images.jianshu.io/upload_images/12857030-999a620338566bdb.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

- 在`HTCommon`文件夹中，创建`System`文件夹,System文件夹中创建`machine`文件夹
- 找到文件：`xnu-6153.41.3 --> osfmk --> machine --> cpu_capabilities.h`,复制到`HTCommon/System/machine`文件夹中

##### 8. 'os/tsd.h' file not found

![image.png](https://upload-images.jianshu.io/upload_images/12857030-5d4e25267bf81c59.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
- 找到文件：`xnu-6153.41.3 --> libsyscall --> os --> tsd.h`,复制到`HTCommon/os`文件夹中

##### 9. 'System/pthread_machdep.h' file not found

![image.png](https://upload-images.jianshu.io/upload_images/12857030-cbccf41a33ceaa3e.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

- [在这里下载](https://opensource.apple.com/source/Libc/)找到 `Libc-583/pthreads/pthread_machdep.h`, 将其复制到`HTCommon/System`文件夹。
**手动复制吧 😂**

> 在最新版的macOS 10.15中最新版下载的`libc`中没有这个h文件，需要下载[`Libc-583`版本](https://opensource.apple.com/source/Libc/Libc-583/pthreads/pthread_machdep.h.auto.html)

##### 10. 'CrashReporterClient.h' file not found
![image.png](https://upload-images.jianshu.io/upload_images/12857030-f3bb4ec42c447b3e.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

- [在这里复制](https://opensource.apple.com/source/Libc/Libc-825.24/include/CrashReporterClient.h.auto.html)`CrashReporterClient.h`, 将其复制到`HTCommon`文件夹。
- 在 `Build Settings `搜索`Preprocessor Macros`, 加入：`LIBC_NO_LIBCRASHREPORTERCLIENT`

##### 11. 'objc-shared-cache.h' file not found
![image.png](https://upload-images.jianshu.io/upload_images/12857030-b9419ecd2759d758.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

- 找到文件：`dyld-733.6 --> include --> objc-shared-cache.h`,复制到`HTCommon`文件夹中

##### 12. pthread_machdep.h文件报了一堆错

![企业微信截图_4579859e-732a-456b-ad00-2d0bd21b7aad.png](https://upload-images.jianshu.io/upload_images/12857030-9a1db73315ad8c69.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

- 不要慌，将193行至244行替换以下内容，先运行起来
```
#if TARGET_IPHONE_SIMULATOR || defined(__ppc__) || defined(__ppc64__) || \
    (defined(__arm__) && !defined(_ARM_ARCH_7) && defined(_ARM_ARCH_6) && defined(__thumb__))

#define _pthread_getspecific_direct(key) pthread_getspecific((key))
#define _pthread_setspecific_direct(key, val) pthread_setspecific((key), (val))

#else
#endif
```

##### 13. Use of undeclared identifier 'DYLD_MACOSX_VERSION_10_13'

![image.png](https://upload-images.jianshu.io/upload_images/12857030-cc3e797c4d7f9931.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

- 我们在`HTCommon/mach-o/dyld_priv.h`文件顶部`加入`缺失的`宏`
```
#define DYLD_MACOSX_VERSION_10_11 0x000A0B00
#define DYLD_MACOSX_VERSION_10_12 0x000A0C00
#define DYLD_MACOSX_VERSION_10_13 0x000A0D00
#define DYLD_MACOSX_VERSION_10_14 0x000A0E00
```
##### 14. 'Block_private.h' file not found

![image.png](https://upload-images.jianshu.io/upload_images/12857030-1355c75382391833.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

- 找到文件：`libclosure-74 -> Block_private.h`，复制到`HTCommon`文件夹中

##### 15. '_simple.h' file not found

![image.png](https://upload-images.jianshu.io/upload_images/12857030-bb70aaf1f8a687d0.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

- 找到文件：`libplatform-220 ->  private -> _simple.h`，复制到`HTCommon`文件夹中

##### 16.'kern/restartable.h' file not found

![image.png](https://upload-images.jianshu.io/upload_images/12857030-d232107b51e936c4.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

- 在`HTCommon`文件夹中，创建`kern`文件
- 找到文件：`xnu-6153.41.3 ->  osfmk ->  kern -> restartable.h`，复制到`HTCommon/kern`文件夹中

##### 17.can't open order file

![image.png](https://upload-images.jianshu.io/upload_images/12857030-4cc0215b8c6aee7a.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
- 选择 `target -> objc -> Build Settings`
- 在工程的 `Order File` 中添加搜索路径 `$(SRCROOT)/libobjc.order`

![image.png](https://upload-images.jianshu.io/upload_images/12857030-bde47e0c82f77f21.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

##### 18.library not found for -lCrashReporterClient

![image.png](https://upload-images.jianshu.io/upload_images/12857030-b2143a3b4d5ccf71.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

- 选择`target -> objc -> BuildSettings`
- 搜索`Other Linker Flags`， 删除`lCrashReporterClient`（`Debug`和`Release`都删）

![image.png](https://upload-images.jianshu.io/upload_images/12857030-74e215e3794aa193.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

##### 19. SDK "macosx.internal" cannot be located. 脚本编译问题

![image.png](https://upload-images.jianshu.io/upload_images/12857030-8f2cee0b4a0bd358.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

- 选择`target -> objc -> Build Phases -> Run Script(markgc)`
- 将`macosx.internal`改为`macosx`

![企业微信截图_95fa0b59-d067-4d4f-8971-9014160a601d.png](https://upload-images.jianshu.io/upload_images/12857030-1afdcec2549e6bdf.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

# 编译成功！恭喜你！ 👍
![image.png](https://upload-images.jianshu.io/upload_images/12857030-5c530cfdd7dcf927.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

---

源码已撸好，配置新target，开启你的探索之路：
#### 1.  新建`Target`： HTTest

![image.png](https://upload-images.jianshu.io/upload_images/12857030-d7c719f7975ad853.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

![image.png](https://upload-images.jianshu.io/upload_images/12857030-9fa5d24759aa9072.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

- 绑定二进制依赖关系

![image.png](https://upload-images.jianshu.io/upload_images/12857030-af383c847cf0556c.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
- 运行`HTTest`代码，自由编译调试

![image.png](https://upload-images.jianshu.io/upload_images/12857030-47eca120990e31b4.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

新世界的通道已搭建稳定。既然OC是面向对象的语言，那就让我们从万物始源alloc讲起！
👇
[OC底层原理三：初探alloc （你好，alloc大佬 ）]()











