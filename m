Return-Path: <tkulkarni@identifeye.health>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D594C021A4
	for <webhook@archiver.kernel.org>; Mon, 24 Feb 2025 19:21:28 +0000 (UTC)
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
 by mx.groups.io with SMTP id smtpd.web11.99099.1740424882710495256
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 24 Feb 2025 11:21:22 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@identifeye.health header.s=google header.b=L3IhQ7Vd;
 spf=pass (domain: identifeye.health, ip: 209.85.216.50, mailfrom: tkulkarni@identifeye.health)
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2fc32756139so7432224a91.1
        for <yocto-patches@lists.yoctoproject.org>; Mon, 24 Feb 2025 11:21:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=identifeye.health; s=google; t=1740424882; x=1741029682; darn=lists.yoctoproject.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wirV7oy56ksHyM6ciMsyTyNSvxa+EKjk3rmIVRM33dQ=;
        b=L3IhQ7VdfJ3ryC+qHXcPsTGbrYV23kETuLwNWakoC4C/+9IM/OcFBeShL//NUNOxOj
         5qKyBi82qD4pQ6wTd2mcjKmR7OSXMl+Y7/Ov36aFHuqB+/d+9Vhkh84dhhEBCnwguKM0
         hHOP6GrD21Zx0dYgnVX7XU6cWeSMpgZTpez0jvmlxOWXycK7NXAhzAhUgfP43/cCGbz8
         codaOaNrHWBlVSLfLqNoT89WcSBw4pzvezp2BxosDqazOcyCliSe9aY45BqvFnWMCfKU
         e4RfGfbiRLdQ/8SPmrDxwdcMN+TG6JSg4eeb4NEnJ55vOdwS0RL5xewVEEz1a0YsK4gC
         2nyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740424882; x=1741029682;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wirV7oy56ksHyM6ciMsyTyNSvxa+EKjk3rmIVRM33dQ=;
        b=JNHL4okTxvom7vhRbiW3PiRx2+orZwDA80EABR2PYY0v1vDBQBbE6tNZl0j7iVOXcV
         TfFvYxRXJDouajU7UBpedUrAjdY/wad/m+Ov9AT5SdVDnoIZ/V2riSCrpFfpIjUH1vcI
         mmpuvifGjeCpIKdUa0Za6bRNe3Wfdrda0Z7fiOUxq+YQIQGWRslVucBtsV4lE+bBuHe8
         0WjJJhtbis0W/6Al19xUFZsvTyl3PpHyRRC3hVVYpVhYFR/VUk5kair4DO5YTf4Jl2MI
         98XVVeAnX+04GQp2vFlEqQc6NNxow4or5IO0lBaEzWl21TlCQYy8lBWHGdOkpoBPoDx/
         Wn5w==
X-Gm-Message-State: AOJu0YwNGtqgpRpK3vyP2NXAHCDR6L2ziqccb2iWptGBCQDSrC4S6CD1
	JOy8ZaxbMRXxiAFc7JL9Gg4ExPft959PBXjW8fIFOcP5cLeELfW907RPR2Mh6YV7YvAEeob+9NX
	ZB5w1U42nECZPTFCCJF1xFNZbfnrfUKBO5+irTqhufvuIqhl6
X-Gm-Gg: ASbGnctIuLlqlxjAQr25lE5N9RTKnx4MLn4BgmKY+jZmkiXDvVENHepRfRnArk+KoGX
	+FLJ+6iVCIhe1w9S6oSCXblxq6wezM0Ce0vgv2xWKz4bbRUuCWC6dYbUTehOY484YpqlbXE+QVQ
	r2Us7e2bE=
X-Google-Smtp-Source: AGHT+IFdJGIle2pJ69wfVSM7fV4k0I8YjYkkgwOGtnS2fXOZ8zXE3sYZDlpHCgi80JlRgIH+9MhWMb/I3MxIjgbWe9c=
X-Received: by 2002:a17:90b:2d4d:b0:2ee:f80c:687c with SMTP id
 98e67ed59e1d1-2fce875d5b4mr21842702a91.31.1740424881808; Mon, 24 Feb 2025
 11:21:21 -0800 (PST)
MIME-Version: 1.0
References: <CAAp=Uw_v_p_XdOn2wHf6bkv72DdK7mpiejJsYfvDRPE_mBj3Pg@mail.gmail.com>
 <CAAp=Uw_xZQHkQuMeS=c3RaS7QRNtT-sdc0iVQ2GTzZ4FdKKZog@mail.gmail.com>
In-Reply-To: <CAAp=Uw_xZQHkQuMeS=c3RaS7QRNtT-sdc0iVQ2GTzZ4FdKKZog@mail.gmail.com>
From: Tushar Kulkarni <tkulkarni@identifeye.health>
Date: Mon, 24 Feb 2025 14:21:10 -0500
X-Gm-Features: AWEUYZnWaIHKWpO9sIgN8qtsHr_iA87ylNN3q1EM5NiuEoL3eZ5-t1fcBFECDSc
Message-ID: <CAAp=Uw-TKrP1JZ944ZvRkAZwhxH6EZxoNq5jG2DzpKbnxehq-A@mail.gmail.com>
Subject: Fwd: meta-security/recipes-security/fscrypt/fscrypt_1.1.0.bb
To: yocto-patches@lists.yoctoproject.org
Content-Type: multipart/alternative; boundary="000000000000d6c008062ee83ec5"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 24 Feb 2025 19:21:28 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1124

--000000000000d6c008062ee83ec5
Content-Type: text/plain; charset="UTF-8"

> Hello,
>  The default recipe does not build in kirsktone branch.  Here is the log
> of the error.  Please suggest any workarounds.
> Regards
>
> NOTE: Executing Tasks
> ERROR: fscrypt-1.0.0-r0 do_compile: oe_runmake failed
> ERROR: fscrypt-1.0.0-r0 do_compile:
> ExecutionError('/home/tkulkarni/tess/tessie-oe4t-yocto/build_tess_seeed/tmp/work/armv8a-oe4t-linux/fscrypt/1.0.0-r0/temp/run.do_compile.2218562',
> 1, None, None)
> ERROR: Logfile of failure stored in:
> /home/tkulkarni/tess/tessie-oe4t-yocto/build_tess_seeed/tmp/work/armv8a-oe4t-linux/fscrypt/1.0.0-r0/temp/log.do_compile.2218562
> Log data follows:
> | DEBUG: Executing shell function do_compile
> | NOTE: make -j4
> | go build --ldflags '-s -w -X "main.version=v0.3.0-26-g92b1e9a"
> -extldflags "-Wl,-O1 -Wl,--hash-style=gnu -Wl,--as-needed
> -fmacro-prefix-map=/home/tkulkarni/tess/tessie-oe4t-yocto/build_tess_seeed/tmp/work/armv8a-oe4t-linux/fscrypt/1.0.0-r0=/usr/src/debug/fscrypt/1.0.0-r0
>
>  -fdebug-prefix-map=/home/tkulkarni/tess/tessie-oe4t-yocto/build_tess_seeed/tmp/work/armv8a-oe4t-linux/fscrypt/1.0.0-r0=/usr/src/debug/fscrypt/1.0.0-r0
>
>  -fdebug-prefix-map=/home/tkulkarni/tess/tessie-oe4t-yocto/build_tess_seeed/tmp/work/armv8a-oe4t-linux/fscrypt/1.0.0-r0/recipe-sysroot=
>
>  -fdebug-prefix-map=/home/tkulkarni/tess/tessie-oe4t-yocto/build_tess_seeed/tmp/work/armv8a-oe4t-linux/fscrypt/1.0.0-r0/recipe-sysroot-native=
>  -Wl,-z,relro,-z,now"' -trimpath -o bin/fscrypt ./cmd/fscrypt
> | go build --ldflags '-s -w -X "main.version=v0.3.0-26-g92b1e9a"
> -extldflags "-Wl,-O1 -Wl,--hash-style=gnu -Wl,--as-needed
> -fmacro-prefix-map=/home/tkulkarni/tess/tessie-oe4t-yocto/build_tess_seeed/tmp/work/armv8a-oe4t-linux/fscrypt/1.0.0-r0=/usr/src/debug/fscrypt/1.0.0-r0
>
>  -fdebug-prefix-map=/home/tkulkarni/tess/tessie-oe4t-yocto/build_tess_seeed/tmp/work/armv8a-oe4t-linux/fscrypt/1.0.0-r0=/usr/src/debug/fscrypt/1.0.0-r0
>
>  -fdebug-prefix-map=/home/tkulkarni/tess/tessie-oe4t-yocto/build_tess_seeed/tmp/work/armv8a-oe4t-linux/fscrypt/1.0.0-r0/recipe-sysroot=
>
>  -fdebug-prefix-map=/home/tkulkarni/tess/tessie-oe4t-yocto/build_tess_seeed/tmp/work/armv8a-oe4t-linux/fscrypt/1.0.0-r0/recipe-sysroot-native=
>  -Wl,-z,relro,-z,now"' -trimpath -buildmode=c-shared -o bin/pam_fscrypt.so
> ./pam_fscrypt
> | go: github.com/client9/misspell@v0.3.4: Get "
> https://proxy.golang.org/github.com/client9/misspell/@v/v0.3.4.mod": dial
> tcp: lookup proxy.golang.org: no such host
> | go: github.com/client9/misspell@v0.3.4: Get "
> https://proxy.golang.org/github.com/client9/misspell/@v/v0.3.4.mod": dial
> tcp: lookup proxy.golang.org: no such host
> | go: downloading github.com/pkg/errors v0.8.0
> | go: downloading golang.org/x/sys v0.0.0-20201119102817-f84b799fce68
> | go: downloading github.com/golang/protobuf v1.2.0
> | go: downloading github.com/pkg/errors v0.8.0
> | go: downloading github.com/urfave/cli v1.20.0
> | go: downloading golang.org/x/sys v0.0.0-20201119102817-f84b799fce68
> | go: downloading golang.org/x/crypto v0.0.0-20190510104115-cbcb75029529
> | go: downloading golang.org/x/term v0.0.0-20210422114643-f5beecf764ed
> | go: downloading golang.org/x/crypto v0.0.0-20190510104115-cbcb75029529
> | go: downloading github.com/golang/protobuf v1.2.0
> | go: github.com/client9/misspell@v0.3.4: Get "
> https://proxy.golang.org/github.com/client9/misspell/@v/v0.3.4.mod": dial
> tcp: lookup proxy.golang.org: no such host
> | go: github.com/client9/misspell@v0.3.4: Get "
> https://proxy.golang.org/github.com/client9/misspell/@v/v0.3.4.mod": dial
> tcp: lookup proxy.golang.org: no such host
> | make: *** [Makefile:99: bin/pam_fscrypt.so] Error 1
> | make: *** Waiting for unfinished jobs....
> | make: *** [Makefile:96: bin/fscrypt] Error 1
> | ERROR: oe_runmake failed
> | WARNING: exit code 1 from a shell command.
> ERROR: Task
> (/home/tkulkarni/tess/tessie-oe4t-yocto/layers/meta-security/recipes-security/fscrypt/fscrypt_1.0.0.bb:do_compile)
> failed with exit code '1'
> NOTE: Tasks Summary: Attempted 844 tasks of which 841 didn't need to be
> rerun and 1 failed.
> NOTE: Writing buildhistory
> NOTE: Writing buildhistory took: 9 seconds
>
> Summary: 1 task failed:
>

--000000000000d6c008062ee83ec5
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_quote gmail_quote_container"><div dir=
=3D"ltr" class=3D"gmail_attr"><br></div><br><br><div dir=3D"ltr"><div class=
=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px =
0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><div dir=
=3D"ltr"><div dir=3D"ltr"><br>Hello,<div>=C2=A0The default recipe=C2=A0does=
 not build in kirsktone=C2=A0branch.=C2=A0 Here is the log of the error.=C2=
=A0 Please suggest any workarounds.</div><div>Regards</div><div><br></div><=
div>NOTE: Executing Tasks<br>ERROR: fscrypt-1.0.0-r0 do_compile: oe_runmake=
 failed</div><div>ERROR: fscrypt-1.0.0-r0 do_compile: ExecutionError(&#39;/=
home/tkulkarni/tess/tessie-oe4t-yocto/build_tess_seeed/tmp/work/armv8a-oe4t=
-linux/fscrypt/1.0.0-r0/temp/run.do_compile.2218562&#39;, 1, None, None)<br=
>ERROR: Logfile of failure stored in: /home/tkulkarni/tess/tessie-oe4t-yoct=
o/build_tess_seeed/tmp/work/armv8a-oe4t-linux/fscrypt/1.0.0-r0/temp/log.do_=
compile.2218562<br>Log data follows:<br>| DEBUG: Executing shell function d=
o_compile<br>| NOTE: make -j4<br>| go build --ldflags &#39;-s -w -X &quot;m=
ain.version=3Dv0.3.0-26-g92b1e9a&quot; -extldflags &quot;-Wl,-O1 -Wl,--hash=
-style=3Dgnu -Wl,--as-needed -fmacro-prefix-map=3D/home/tkulkarni/tess/tess=
ie-oe4t-yocto/build_tess_seeed/tmp/work/armv8a-oe4t-linux/fscrypt/1.0.0-r0=
=3D/usr/src/debug/fscrypt/1.0.0-r0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0-fdebug-prefix-map=3D/home/tkulkarni/=
tess/tessie-oe4t-yocto/build_tess_seeed/tmp/work/armv8a-oe4t-linux/fscrypt/=
1.0.0-r0=3D/usr/src/debug/fscrypt/1.0.0-r0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0-fdebug-prefix-map=3D/home/tku=
lkarni/tess/tessie-oe4t-yocto/build_tess_seeed/tmp/work/armv8a-oe4t-linux/f=
scrypt/1.0.0-r0/recipe-sysroot=3D =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0-fdebug-prefix-map=3D/home/tkulkarni/tes=
s/tessie-oe4t-yocto/build_tess_seeed/tmp/work/armv8a-oe4t-linux/fscrypt/1.0=
.0-r0/recipe-sysroot-native=3D =C2=A0-Wl,-z,relro,-z,now&quot;&#39; -trimpa=
th -o bin/fscrypt ./cmd/fscrypt<br>| go build --ldflags &#39;-s -w -X &quot=
;main.version=3Dv0.3.0-26-g92b1e9a&quot; -extldflags &quot;-Wl,-O1 -Wl,--ha=
sh-style=3Dgnu -Wl,--as-needed -fmacro-prefix-map=3D/home/tkulkarni/tess/te=
ssie-oe4t-yocto/build_tess_seeed/tmp/work/armv8a-oe4t-linux/fscrypt/1.0.0-r=
0=3D/usr/src/debug/fscrypt/1.0.0-r0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0-fdebug-prefix-map=3D/home/tkulkarni/=
tess/tessie-oe4t-yocto/build_tess_seeed/tmp/work/armv8a-oe4t-linux/fscrypt/=
1.0.0-r0=3D/usr/src/debug/fscrypt/1.0.0-r0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0-fdebug-prefix-map=3D/home/tku=
lkarni/tess/tessie-oe4t-yocto/build_tess_seeed/tmp/work/armv8a-oe4t-linux/f=
scrypt/1.0.0-r0/recipe-sysroot=3D =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0-fdebug-prefix-map=3D/home/tkulkarni/tes=
s/tessie-oe4t-yocto/build_tess_seeed/tmp/work/armv8a-oe4t-linux/fscrypt/1.0=
.0-r0/recipe-sysroot-native=3D =C2=A0-Wl,-z,relro,-z,now&quot;&#39; -trimpa=
th -buildmode=3Dc-shared -o bin/pam_fscrypt.so ./pam_fscrypt<br>| go: <a hr=
ef=3D"http://github.com/client9/misspell@v0.3.4" target=3D"_blank">github.c=
om/client9/misspell@v0.3.4</a>: Get &quot;<a href=3D"https://proxy.golang.o=
rg/github.com/client9/misspell/@v/v0.3.4.mod" target=3D"_blank">https://pro=
xy.golang.org/github.com/client9/misspell/@v/v0.3.4.mod</a>&quot;: dial tcp=
: lookup <a href=3D"http://proxy.golang.org" target=3D"_blank">proxy.golang=
.org</a>: no such host<br>| go: <a href=3D"http://github.com/client9/misspe=
ll@v0.3.4" target=3D"_blank">github.com/client9/misspell@v0.3.4</a>: Get &q=
uot;<a href=3D"https://proxy.golang.org/github.com/client9/misspell/@v/v0.3=
.4.mod" target=3D"_blank">https://proxy.golang.org/github.com/client9/missp=
ell/@v/v0.3.4.mod</a>&quot;: dial tcp: lookup <a href=3D"http://proxy.golan=
g.org" target=3D"_blank">proxy.golang.org</a>: no such host<br>| go: downlo=
ading <a href=3D"http://github.com/pkg/errors" target=3D"_blank">github.com=
/pkg/errors</a> v0.8.0<br>| go: downloading <a href=3D"http://golang.org/x/=
sys" target=3D"_blank">golang.org/x/sys</a> v0.0.0-20201119102817-f84b799fc=
e68<br>| go: downloading <a href=3D"http://github.com/golang/protobuf" targ=
et=3D"_blank">github.com/golang/protobuf</a> v1.2.0<br>| go: downloading <a=
 href=3D"http://github.com/pkg/errors" target=3D"_blank">github.com/pkg/err=
ors</a> v0.8.0<br>| go: downloading <a href=3D"http://github.com/urfave/cli=
" target=3D"_blank">github.com/urfave/cli</a> v1.20.0<br>| go: downloading =
<a href=3D"http://golang.org/x/sys" target=3D"_blank">golang.org/x/sys</a> =
v0.0.0-20201119102817-f84b799fce68<br>| go: downloading <a href=3D"http://g=
olang.org/x/crypto" target=3D"_blank">golang.org/x/crypto</a> v0.0.0-201905=
10104115-cbcb75029529<br>| go: downloading <a href=3D"http://golang.org/x/t=
erm" target=3D"_blank">golang.org/x/term</a> v0.0.0-20210422114643-f5beecf7=
64ed<br>| go: downloading <a href=3D"http://golang.org/x/crypto" target=3D"=
_blank">golang.org/x/crypto</a> v0.0.0-20190510104115-cbcb75029529<br>| go:=
 downloading <a href=3D"http://github.com/golang/protobuf" target=3D"_blank=
">github.com/golang/protobuf</a> v1.2.0<br>| go: <a href=3D"http://github.c=
om/client9/misspell@v0.3.4" target=3D"_blank">github.com/client9/misspell@v=
0.3.4</a>: Get &quot;<a href=3D"https://proxy.golang.org/github.com/client9=
/misspell/@v/v0.3.4.mod" target=3D"_blank">https://proxy.golang.org/github.=
com/client9/misspell/@v/v0.3.4.mod</a>&quot;: dial tcp: lookup <a href=3D"h=
ttp://proxy.golang.org" target=3D"_blank">proxy.golang.org</a>: no such hos=
t<br>| go: <a href=3D"http://github.com/client9/misspell@v0.3.4" target=3D"=
_blank">github.com/client9/misspell@v0.3.4</a>: Get &quot;<a href=3D"https:=
//proxy.golang.org/github.com/client9/misspell/@v/v0.3.4.mod" target=3D"_bl=
ank">https://proxy.golang.org/github.com/client9/misspell/@v/v0.3.4.mod</a>=
&quot;: dial tcp: lookup <a href=3D"http://proxy.golang.org" target=3D"_bla=
nk">proxy.golang.org</a>: no such host<br>| make: *** [Makefile:99: bin/pam=
_fscrypt.so] Error 1<br>| make: *** Waiting for unfinished jobs....<br>| ma=
ke: *** [Makefile:96: bin/fscrypt] Error 1<br>| ERROR: oe_runmake failed<br=
>| WARNING: exit code 1 from a shell command.<br>ERROR: Task (/home/tkulkar=
ni/tess/tessie-oe4t-yocto/layers/meta-security/recipes-security/fscrypt/fsc=
rypt_1.0.0.bb:do_compile) failed with exit code &#39;1&#39;<br>NOTE: Tasks =
Summary: Attempted 844 tasks of which 841 didn&#39;t need to be rerun and 1=
 failed.<br>NOTE: Writing buildhistory<br>NOTE: Writing buildhistory took: =
9 seconds<br><br>Summary: 1 task failed:<br></div></div>
</div>
</blockquote></div></div>
</div></div>

--000000000000d6c008062ee83ec5--

