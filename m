Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.13556.1793284989462325899
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 29 Oct 2026 07:43:09 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.crashing.org, ip: 63.228.1.57, mailfrom: mark.hatle@kernel.crashing.org)
Received: from kernel.crashing.org (70-99-78-136.nuveramail.net [70.99.78.136] (may be forged))
	by gate.crashing.org (8.18.1/8.18.1/Debian-2) with ESMTP id 69TEh4FI4012460;
	Thu, 29 Oct 2026 09:43:05 -0500
Received: from [192.168.2.94] ([192.168.2.94])
	by kernel.crashing.org (8.14.7/8.14.7) with ESMTP id 69TEh3SS020739;
	Thu, 29 Oct 2026 09:43:04 -0500
Message-ID: <261814b0-effc-4aa8-8b94-b083be2798ec@kernel.crashing.org>
Date: Thu, 29 Oct 2026 09:43:03 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [PATCH] makewrappers: Allow the wrapper
 architecture to be set for cross builds
Content-Language: en-US
To: yocto-patches@lists.yoctoproject.org
Cc: richard.purdie@linuxfoundation.org, liezhi.yang@windriver.com,
        sundeep.kokkonda@windriver.com, Randy.MacLeod@windriver.com
References: <20261029135701.300718-1-sunilkumar.dora@windriver.com>
From: Mark Hatle <mark.hatle@kernel.crashing.org>
In-Reply-To: <20261029135701.300718-1-sunilkumar.dora@windriver.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Thu, 29 Oct 2026 14:43:15 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5184

I would prefer that the configure script is modified with an optional --target= 
value.  This value can then feed through as appropriate.

This way if a user passed ./configure --target=aarch64-foo-linux-gnu ... it'll 
do the things necessary for that.

Then in the other components we can split between target and build host (if 
necessary) behavior.

I don't have much of an opinion on MAKEWRAPPERS_ARCH and the way it's passed 
through the environment to makewrappers, but it does feel a bit strange.  I'm 
wondering if makewrappers would be better if it also took an optional target= 
argument instead of using the environment.

This would result in something like:

configure:

     echo >&2 "usage:"
     echo >&2 "  configure --prefix=..."
     echo >&2 "           [--libdir=...]"
     echo >&2 "           [--suffix=...]"
+   echo >&2 "           [--target=...]"
     echo >&2 "           [--enable-memory-db]"
     echo >&2 "           [--enable-epoll]"
     echo >&2 "           [--enable-xattr]"

target (if set) sends up in "opt_target", which is used to replace @TARGET@ in 
the Makefile.in.


In Makefile.in:

  ARCH_FLAGS=@ARCH_FLAGS@
  MARK64=@MARK64@
  RPATH=@RPATH@
+TARGET_ARCH=@TARGET@
  VERSION=1.99.0

  LIB=@LIB@


  wrappers: makewrappers templatefile.py $(TEMPLATES) ports/*/wrapfuncs.in
-	CC="$(CC) $(CFLAGS) $(CFLAGS_PSEUDO)" ./makewrappers "xattr=$(XATTR)"
+	CC="$(CC) $(CFLAGS) $(CFLAGS_PSEUDO)" ./makewrappers --target=$(TARGET 
"xattr=$(XATTR)"


makewrappers:

def main(argv):
     """Read in function definitions, write out files based on templates."""
     funcs = []
     sources = []

     for arg in argv:
         if arg.startswith('--'):
             # Check here for --target, set global for target
             continue
         if '=' not in arg:
             print("Invalid argument '%s', must be of the form name=value" % arg)
             exit(1)
         name, value = arg.split('=')
         os.environ["port_" + name] = value

Adjust wrapper_arch function in your change to use the new global.

--Mark

On 10/29/26 8:57 AM, Dora, Sunil Kumar via lists.yoctoproject.org wrote:
> From: Sunil Dora <sunilkumar.dora@windriver.com>
> 
> Architecture specific modifiers in wrapfuncs.in, such as
> version-aarch64="GLIBC_2.17" on the xattr wrappers, are selected with
> platform.machine(), so they follow the machine running the script
> rather than the one pseudo is built for. An aarch64 pseudo cross built
> on x86_64 ends up with GLIBC_2.3 and the reverse with GLIBC_2.17, which
> shows up as pseudo not being reproducible between x86_64 and aarch64
> builders.
> 
> Add a MAKEWRAPPERS_ARCH variable the build can set and pass it through
> from the Makefile. Unset, the build machine is used as before.
> 
> [YOCTO #16376]
> 
> Signed-off-by: Sunil Dora <sunilkumar.dora@windriver.com>
> ---
>   Makefile.in  | 5 ++++-
>   makewrappers | 9 +++++++--
>   2 files changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/Makefile.in b/Makefile.in
> index 6640a73..bc2ab92 100644
> --- a/Makefile.in
> +++ b/Makefile.in
> @@ -34,6 +34,9 @@ BITS=@BITS@
>   ARCH_FLAGS=@ARCH_FLAGS@
>   MARK64=@MARK64@
>   RPATH=@RPATH@
> +# Architecture the wrappers are generated for, as a uname -m name.
> +# Empty means the build machine; set it when cross compiling.
> +MAKEWRAPPERS_ARCH ?=
>   VERSION=1.99.0
>   
>   LIB=@LIB@
> @@ -146,7 +149,7 @@ tables: enums/*.in maketables templatefile.py $(TABLES)
>   	./maketables enums/*.in
>   
>   wrappers: makewrappers templatefile.py $(TEMPLATES) ports/*/wrapfuncs.in
> -	CC="$(CC) $(CFLAGS) $(CFLAGS_PSEUDO)" ./makewrappers "xattr=$(XATTR)"
> +	CC="$(CC) $(CFLAGS) $(CFLAGS_PSEUDO)" MAKEWRAPPERS_ARCH="$(MAKEWRAPPERS_ARCH)" ./makewrappers "xattr=$(XATTR)"
>   
>   .SECONDARY: tables wrappers
>   
> diff --git a/makewrappers b/makewrappers
> index 19508fa..c90f5c7 100755
> --- a/makewrappers
> +++ b/makewrappers
> @@ -15,6 +15,10 @@ import platform
>   import subprocess
>   from templatefile import TemplateFile
>   
> +def wrapper_arch():
> +    """Architecture the wrappers are built for: MAKEWRAPPERS_ARCH or the build machine."""
> +    return os.environ.get("MAKEWRAPPERS_ARCH", "").strip() or platform.machine()
> +
>   class ArgumentList:
>       """A (possibly empty) list of arguments"""
>   
> @@ -319,11 +323,11 @@ class Function:
>               # Strip all leading/trailing whitespace
>               modifiers = {k.strip():v.strip() for k, v in modifiers.items()}
>   
> -            arch = "-" + platform.machine()
> +            arch = "-" + wrapper_arch()
>               # Sorted so that versions-foo appear after versions, so overrides are easy
>               for key in sorted(modifiers):
>                   value = modifiers[key].replace('<equals>', '==')
> -                # If the key is version-arm64 and we're on arm64 then rename this to version
> +                # If the key is version-arm64 and we're building for arm64 then rename this to version
>                   if key.endswith(arch):
>                       key = key.replace(arch, "")
>                   setattr(self, key, value)
> @@ -702,6 +706,7 @@ def main(argv):
>       port = Port('common', sources)
>   
>       # the per-function stuff
> +    print("Architecture for wrapper modifiers: %s" % wrapper_arch())
>       print("Writing functions...")
>       all_funcs = port.functions()
>       for name in sorted(all_funcs.keys()):
