Return-Path: <mark.hatle@kernel.crashing.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47899C35FF8
	for <webhook@archiver.kernel.org>; Tue, 18 Mar 2025 20:23:47 +0000 (UTC)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 by mx.groups.io with SMTP id smtpd.web10.5531.1742329421027610518
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 18 Mar 2025 13:23:41 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.crashing.org, ip: 63.228.1.57, mailfrom: mark.hatle@kernel.crashing.org)
Received: from kernel.crashing.org (70-99-78-136.nuveramail.net [70.99.78.136] (may be forged))
	by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 52IKNciF027006;
	Tue, 18 Mar 2025 15:23:39 -0500
Received: from [192.168.2.109] ([192.168.2.109])
	by kernel.crashing.org (8.14.7/8.14.7) with ESMTP id 52IKNbK3005191;
	Tue, 18 Mar 2025 15:23:38 -0500
Message-ID: <612177a2-3240-4ce6-84af-fbf4ef8c99f8@kernel.crashing.org>
Date: Tue, 18 Mar 2025 15:23:37 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [pseudo] [PATCH 1/3] pseudo_wrappers.c: Add
 support for LoongArch64
Content-Language: en-US
To: yocto-patches@lists.yoctoproject.org
Cc: Xiaotian Wu <wuxiaotian@loongson.cn>
References: <20250309060039.454124-1-wuxiaotian@loongson.cn>
 <20250309060039.454124-2-wuxiaotian@loongson.cn>
From: Mark Hatle <mark.hatle@kernel.crashing.org>
In-Reply-To: <20250309060039.454124-2-wuxiaotian@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 18 Mar 2025 20:23:47 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1218

I've reviewed this, and it looks reasonable.  As we go forward and work to 
remove out of date symbols, we may have to do something similar on other 
architectures.  But I'm not completely sure yet.

Reviewed-by: Mark Hatle <mark.hatle@kernel.crashing.org>

On 3/9/25 12:00 AM, Xiaotian Wu wrote:
> Since these symbols do not exist in LoongArch's libc.so, they
> need to be remapped, and the first "ver" function parameter
> does not exist in the mapped function.
> 
> __fxstat __fxstat64 __fxstatat __fxstatat64 __lxstat __lxstat64
> __xmknod __xmknodat __xstat __xstat64
> 
> Signed-off-by: Xiaotian Wu <wuxiaotian@loongson.cn>
> ---
>   pseudo_wrappers.c | 70 +++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 70 insertions(+)
> 
> diff --git a/pseudo_wrappers.c b/pseudo_wrappers.c
> index 9ae1200..b54b0c3 100644
> --- a/pseudo_wrappers.c
> +++ b/pseudo_wrappers.c
> @@ -122,6 +122,64 @@ pseudo_reinit_libpseudo(void) {
>   	_libpseudo_init();
>   }
>   
> +#if defined(__loongarch_lp64)
> +#define LOAD_REAL_SYMBOL(name, symbol) \
> +    pseudo_real_##name = dlsym(RTLD_NEXT, symbol); \
> +    real_##name = pseudo_##name
> +
> +static int (*pseudo_real___fxstat)(int fd, struct stat *buf) = NULL;
> +static int (*pseudo_real___fxstat64)(int fd, struct stat64 *buf) = NULL;
> +static int (*pseudo_real___fxstatat)(int dirfd, const char *path, struct stat *buf, int flags) = NULL;
> +static int (*pseudo_real___fxstatat64)(int dirfd, const char *path, struct stat64 *buf, int flags) = NULL;
> +static int (*pseudo_real___lxstat)(const char *path, struct stat *buf) = NULL;
> +static int (*pseudo_real___lxstat64)(const char *path, struct stat64 *buf) = NULL;
> +static int (*pseudo_real___xmknod)(const char *path, mode_t mode, dev_t *dev) = NULL;
> +static int (*pseudo_real___xmknodat)(int dirfd, const char *path, mode_t mode, dev_t *dev) = NULL;
> +static int (*pseudo_real___xstat)(const char *path, struct stat *buf) = NULL;
> +static int (*pseudo_real___xstat64)(const char *path, struct stat64 *buf) = NULL;
> +
> +static int pseudo___fxstat(int ver __attribute__((unused)), int fd, struct stat *buf)
> +{
> +	return pseudo_real___fxstat(fd, buf);
> +}
> +static int pseudo___fxstat64(int ver __attribute__((unused)), int fd, struct stat64 *buf)
> +{
> +	return pseudo_real___fxstat64(fd, buf);
> +}
> +static int pseudo___fxstatat(int ver __attribute__((unused)), int dirfd, const char *path, struct stat *buf, int flags)
> +{
> +	return pseudo_real___fxstatat(dirfd, path, buf, flags);
> +}
> +static int pseudo___fxstatat64(int ver __attribute__((unused)), int dirfd, const char *path, struct stat64 *buf, int flags)
> +{
> +	return pseudo_real___fxstatat64(dirfd, path, buf, flags);
> +}
> +static int pseudo___lxstat(int ver __attribute__((unused)), const char *path, struct stat *buf)
> +{
> +	return pseudo_real___lxstat(path, buf);
> +}
> +static int pseudo___lxstat64(int ver __attribute__((unused)), const char *path, struct stat64 *buf)
> +{
> +	return pseudo_real___lxstat64(path, buf);
> +}
> +static int pseudo___xmknod(int ver __attribute__((unused)), const char *path, mode_t mode, dev_t *dev)
> +{
> +	return pseudo_real___xmknod(path, mode, dev);
> +}
> +static int pseudo___xmknodat(int ver __attribute__((unused)), int dirfd, const char *path, mode_t mode, dev_t *dev)
> +{
> +	return pseudo_real___xmknodat(dirfd, path, mode, dev);
> +}
> +static int pseudo___xstat(int ver __attribute__((unused)), const char *path, struct stat *buf)
> +{
> +	return pseudo_real___xstat(path, buf);
> +}
> +static int pseudo___xstat64(int ver __attribute__((unused)), const char *path, struct stat64 *buf)
> +{
> +	return pseudo_real___xstat64(path, buf);
> +}
> +#endif
> +
>   static void
>   pseudo_init_one_wrapper(pseudo_function *func) {
>   	int (*f)(void) = (int (*)(void)) NULL;
> @@ -185,6 +243,18 @@ pseudo_init_wrappers(void) {
>   	pseudo_real_fork = dlsym(RTLD_NEXT, "fork");
>   	pseudo_real_execv = dlsym(RTLD_NEXT, "execv");
>   
> +#if defined(__loongarch_lp64)
> +	LOAD_REAL_SYMBOL(__fxstat, "fstat");
> +	LOAD_REAL_SYMBOL(__fxstat64, "fstat64");
> +	LOAD_REAL_SYMBOL(__fxstatat, "fstatat");
> +	LOAD_REAL_SYMBOL(__fxstatat64, "fstatat64");
> +	LOAD_REAL_SYMBOL(__lxstat, "lstat");
> +	LOAD_REAL_SYMBOL(__lxstat64, "lstat64");
> +	LOAD_REAL_SYMBOL(__xmknod, "mknod");
> +	LOAD_REAL_SYMBOL(__xmknodat, "mknodat");
> +	LOAD_REAL_SYMBOL(__xstat, "stat");
> +	LOAD_REAL_SYMBOL(__xstat64, "stat64");
> +#endif
>   	/* Once the wrappers are setup, we can now use open... so
>   	 * setup the logfile, if necessary...
>   	 */

