Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.38073.1793894841104272215
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 05 Nov 2026 08:07:21 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.crashing.org, ip: 63.228.1.57, mailfrom: mark.hatle@kernel.crashing.org)
Received: from kernel.crashing.org (70-99-78-136.nuveramail.net [70.99.78.136] (may be forged))
	by gate.crashing.org (8.18.1/8.18.1/Debian-2) with ESMTP id 6A5G7HYP1304455;
	Thu, 5 Nov 2026 10:07:17 -0600
Received: from [192.168.2.194] ([192.168.2.194])
	by kernel.crashing.org (8.14.7/8.14.7) with ESMTP id 6A5G7GlQ025037;
	Thu, 5 Nov 2026 10:07:16 -0600
Message-ID: <9dfa6660-201e-4120-b558-de3780d62434@kernel.crashing.org>
Date: Thu, 5 Nov 2026 10:07:15 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [pseudo][PATCH v3] makewrappers: Allow the
 wrapper architecture to be set for cross builds
Content-Language: en-US
To: yocto-patches@lists.yoctoproject.org,
        Richard Purdie <richard.purdie@linuxfoundation.org>,
        Simon Marchi <simark@simark.ca>
Cc: "Term Yang, Liezhi" <Liezhi.Yang@windriver.com>,
        "Kokkonda, Sundeep" <Sundeep.Kokkonda@windriver.com>
References: <20261030185645.765144-1-sunilkumar.dora@windriver.com>
 <82733a32-8abd-4d2e-84e3-fa876d516917@windriver.com>
From: Mark Hatle <mark.hatle@kernel.crashing.org>
In-Reply-To: <82733a32-8abd-4d2e-84e3-fa876d516917@windriver.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Thu, 05 Nov 2026 16:07:30 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5243

I plan to review this today or tomorrow.  Sorry for the delay.

--Mark

On 11/5/26 6:42 AM, Dora, Sunil Kumar via yocto-patches wrote:
> Hi Mark, Richard,
> 
> Gentle ping on this. v3 only adds the [pseudo] subject tag over v2,
> which switched to configure --target
> as Mark suggested.
> 
> Any Comments?
> 
> Thanks,
> Sunil
> 
> On 10/31/2026 12:27 AM, Dora, Sunil Kumar wrote:
>> From: Sunil Dora <sunilkumar.dora@windriver.com>
>>
>> Architecture specific modifiers in wrapfuncs.in, such as
>> version-aarch64="GLIBC_2.17" on the xattr wrappers, are selected with
>> platform.machine(), so they follow the machine running the script
>> rather than the one pseudo is built for. An aarch64 pseudo cross built
>> on x86_64 ends up with GLIBC_2.3 and the reverse with GLIBC_2.17, which
>> shows up as pseudo not being reproducible between x86_64 and aarch64
>> builders.
>>
>> Add a --target option to configure and pass it on to makewrappers,
>> which uses the cpu part of the triplet for these modifiers. Without
>> --target the build machine is used as before.
>>
>> [YOCTO #16376]
>>
>> Signed-off-by: Sunil Dora <sunilkumar.dora@windriver.com>
>> ---
>> v3: I missed the [pseudo] tag in the subject.
>>
>> v2: use a configure --target option and a makewrappers --target argument
>>       instead of the MAKEWRAPPERS_ARCH environment variable, as suggested by
>>       Mark. Without --target the generated wrapper table is unchanged.
>>
>>    Makefile.in  |  3 ++-
>>    configure    |  6 ++++++
>>    makewrappers | 17 +++++++++++++++--
>>    3 files changed, 23 insertions(+), 3 deletions(-)
>>
>> diff --git a/Makefile.in b/Makefile.in
>> index 6640a73..9c6da77 100644
>> --- a/Makefile.in
>> +++ b/Makefile.in
>> @@ -34,6 +34,7 @@ BITS=@BITS@
>>    ARCH_FLAGS=@ARCH_FLAGS@
>>    MARK64=@MARK64@
>>    RPATH=@RPATH@
>> +TARGET=@TARGET@
>>    VERSION=1.99.0
>>    
>>    LIB=@LIB@
>> @@ -146,7 +147,7 @@ tables: enums/*.in maketables templatefile.py $(TABLES)
>>    	./maketables enums/*.in
>>    
>>    wrappers: makewrappers templatefile.py $(TEMPLATES) ports/*/wrapfuncs.in
>> -	CC="$(CC) $(CFLAGS) $(CFLAGS_PSEUDO)" ./makewrappers "xattr=$(XATTR)"
>> +	CC="$(CC) $(CFLAGS) $(CFLAGS_PSEUDO)" ./makewrappers --target="$(TARGET)" "xattr=$(XATTR)"
>>    
>>    .SECONDARY: tables wrappers
>>    
>> diff --git a/configure b/configure
>> index 68c9962..b43809e 100755
>> --- a/configure
>> +++ b/configure
>> @@ -10,6 +10,7 @@
>>    opt_prefix=
>>    opt_libdir=
>>    opt_suffix=
>> +opt_target=
>>    opt_arch=x86
>>    opt_bits=
>>    opt_sqlite=/usr
>> @@ -32,6 +33,7 @@ usage()
>>        echo >&2 "  configure --prefix=..."
>>        echo >&2 "           [--libdir=...]"
>>        echo >&2 "           [--suffix=...]"
>> +    echo >&2 "           [--target=...]"
>>        echo >&2 "           [--enable-memory-db]"
>>        echo >&2 "           [--enable-epoll]"
>>        echo >&2 "           [--enable-xattr]"
>> @@ -153,6 +155,9 @@ do
>>        --suffix=*)
>>            opt_suffix=${arg#--suffix=}
>>            ;;
>> +    --target=*)
>> +        opt_target=${arg#--target=}
>> +        ;;
>>        --arch=*)
>>            echo >&2 "WARNING: The --arch option is now deprecated. Use --cflags."
>>            opt_arch=${arg#--arch=}
>> @@ -341,6 +346,7 @@ sed -e '
>>      s,@LIBDIR@,'"$opt_libdir"',g
>>      s,@LIB@,'"$opt_lib"',g
>>      s,@SUFFIX@,'"$opt_suffix"',g
>> +  s,@TARGET@,'"$opt_target"',g
>>      s,@SQLITE@,'"$opt_sqlite"',g
>>      s,@ARCH_FLAGS@,'"$arch_flags"',g
>>      s,@DEFAULT_SQLITE@,'"$default_sqlite"',g
>> diff --git a/makewrappers b/makewrappers
>> index 19508fa..7cf2862 100755
>> --- a/makewrappers
>> +++ b/makewrappers
>> @@ -15,6 +15,13 @@ import platform
>>    import subprocess
>>    from templatefile import TemplateFile
>>    
>> +# Set from --target=, empty means the machine running this script
>> +target_arch = ""
>> +
>> +def wrapper_arch():
>> +    """Architecture the wrappers are built for: the --target cpu or the build machine."""
>> +    return target_arch or platform.machine()
>> +
>>    class ArgumentList:
>>        """A (possibly empty) list of arguments"""
>>    
>> @@ -319,11 +326,11 @@ class Function:
>>                # Strip all leading/trailing whitespace
>>                modifiers = {k.strip():v.strip() for k, v in modifiers.items()}
>>    
>> -            arch = "-" + platform.machine()
>> +            arch = "-" + wrapper_arch()
>>                # Sorted so that versions-foo appear after versions, so overrides are easy
>>                for key in sorted(modifiers):
>>                    value = modifiers[key].replace('<equals>', '==')
>> -                # If the key is version-arm64 and we're on arm64 then rename this to version
>> +                # If the key is version-arm64 and we're building for arm64 then rename this to version
>>                    if key.endswith(arch):
>>                        key = key.replace(arch, "")
>>                    setattr(self, key, value)
>> @@ -669,10 +676,15 @@ def process_wrapfuncs(port):
>>    
>>    def main(argv):
>>        """Read in function definitions, write out files based on templates."""
>> +    global target_arch
>>        funcs = []
>>        sources = []
>>    
>>        for arg in argv:
>> +        if arg.startswith('--target='):
>> +            # A GNU triplet such as aarch64-poky-linux, only the cpu part is used
>> +            target_arch = arg[len('--target='):].split('-')[0]
>> +            continue
>>            if '=' not in arg:
>>                print("Invalid argument '%s', must be of the form name=value" % arg)
>>                exit(1)
>> @@ -702,6 +714,7 @@ def main(argv):
>>        port = Port('common', sources)
>>    
>>        # the per-function stuff
>> +    print("Architecture for wrapper modifiers: %s" % wrapper_arch())
>>        print("Writing functions...")
>>        all_funcs = port.functions()
>>        for name in sorted(all_funcs.keys()):
> 
> 
> 
> 
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#5242): https://lists.yoctoproject.org/g/yocto-patches/message/5242
> Mute This Topic: https://lists.yoctoproject.org/mt/122016992/3616948
> Group Owner: yocto-patches+owner@lists.yoctoproject.org
> Unsubscribe: https://lists.yoctoproject.org/g/yocto-patches/leave/13201099/3616948/947757854/xyzzy [mark.hatle@kernel.crashing.org]
> -=-=-=-=-=-=-=-=-=-=-=-
> 
> 
