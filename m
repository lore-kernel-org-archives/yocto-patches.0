Return-Path: <bruce.ashfield@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6702CFD354
	for <webhook@archiver.kernel.org>; Mon, 24 Nov 2025 19:36:53 +0000 (UTC)
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.51.1764013005619395517
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 24 Nov 2025 11:36:45 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=Pq4xJTf5;
 spf=pass (domain: gmail.com, ip: 209.85.216.50, mailfrom: bruce.ashfield@gmail.com)
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-343ea89896eso4862042a91.2
        for <yocto-patches@lists.yoctoproject.org>; Mon, 24 Nov 2025 11:36:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764013004; x=1764617804; darn=lists.yoctoproject.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=F3jgOuCbBFdUmRw/huu1ncukrzxmpKLjP3PMegWQh0Q=;
        b=Pq4xJTf5iSPHifSNrOEsD0B/HDyVozCLBNC1zctLAh/Pbgi4ORYk6E/VajwwJDRLmK
         EnUBKvLJM91vDa6fRDrXhdLj6Kc1qk6df4kK//BmtEGey6N6TYNdJMWcxLZyt+5ZaTfb
         MIQyJKw4O2sGuiQnpKd1bge0LsJRqINF4zVV4b6ehckCqqULXN68mg6VQu69yy9mufHw
         TSdciudbufEvagTjYNEGwpHULw4M4EGGRaO+SIDiVx6jfHRBspMpE7+rjCRa4lLMEV0d
         n/59/4eycBLEFY/0IJK5D3YRQ8AZ/ts3XDlLi1qNZp50FzC1ZrAPDQ/VLUh+yLInLROm
         9cuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764013004; x=1764617804;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F3jgOuCbBFdUmRw/huu1ncukrzxmpKLjP3PMegWQh0Q=;
        b=eKKWyV5asng77KiCdStKSKyCXlQTvwzDomnMp5Rbzb3PAEI6Vc5oe6lTD2e05uSIfc
         PIYG8tTPNbrJBb+nWLNR6CcnQyhqNwZwugxTjXl6DnxeL8aye5TfmPsbxfGW1TSMnK89
         SXcZNHVfmAIpmg1Jlzp1VRINGDhqKSXdJU7/cBA8oYA5s32mCByL90vxfDztY5HtJR+T
         9mKXRFTghfS8JSq4qZlD/94z13Y7IXao/h6pCM4BrPC4V+UirJOd9gSkXlKZXvDw+b8D
         99Ca291VsxDS7u4Y5LFTh2hYo+5SdDw4uAQWhZMCP5br4G4APOBjXJ0WhgJvDTw9n5Cs
         qH1A==
X-Gm-Message-State: AOJu0YxGzT7z+wCxcV1geroTBynp4Fi/MOKIXTHp32yPyPuqfxg5ikq0
	DwwPeEP1CrYWEAPALJvQ5YK3kU4UReQaZzvN2N0cVPl2JsIxJAtJn0PyCL5ZrDokUliagEeeRCN
	pkwW53n9ToMzCmYSgW0Cq8J5yN4bp7No=
X-Gm-Gg: ASbGnctqKAt5Z2/29FexVM7MAI7C27DGYyokMLX3IoD5biV2WSe6UyjWWr15wUUC7G2
	lLe86HNUZa/aQizmes8sasO7CoAO3eLq3PPLIxW6OhwmvzbEToGUFQXs7bRWkwfMzxTc4yGlgNC
	9qhQRYoCPJhpIAt1BBZxPXv5WRkZe4wMN4YWYr7lTpvIXDKa7n9r3a8LIe9dToizxWj3yI30+sM
	Ul+KpFDbtt9n6LHMLm9NoKru9/pPylvr5Dh7OV33i2vFshTzOjxZ5Q5/FMcQT3CqQ33JRQK
X-Google-Smtp-Source: AGHT+IEU9H2EeeXOHDCM8NGz4HJRy09sxzP7VporPi7xeZRTqeZXnExIi0wqxrsbwvZ/VEaNQ2qRqmGwSQjJDfIW0QA=
X-Received: by 2002:a17:90b:2fc8:b0:341:69e3:785a with SMTP id
 98e67ed59e1d1-34733e6b39bmr12654108a91.16.1764013003804; Mon, 24 Nov 2025
 11:36:43 -0800 (PST)
MIME-Version: 1.0
References: <20251124183534.870124-1-ross.burton@arm.com> <20251124183534.870124-2-ross.burton@arm.com>
In-Reply-To: <20251124183534.870124-2-ross.burton@arm.com>
From: Bruce Ashfield <bruce.ashfield@gmail.com>
Date: Mon, 24 Nov 2025 14:36:32 -0500
X-Gm-Features: AWmQ_bmJu3_fz6S07IcXhc7oSDVqs1DEMZFuOBDmgzFxzVQxu9k6iRVoaYwPz5k
Message-ID: <CADkTA4P+j+=tY7Qo76_8aMF46NSY_a8kHz7BzxEWJrUUicN+SQ@mail.gmail.com>
Subject: Re: [PATCH kernel-module-hello-world 2/2] Makefile: cleanup, use KERNEL_SRC
To: Ross Burton <ross.burton@arm.com>
Cc: yocto-patches@lists.yoctoproject.org
Content-Type: multipart/alternative; boundary="00000000000078940806445c484d"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 24 Nov 2025 19:36:53 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2704

--00000000000078940806445c484d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Acked-by: Bruce Ashfield <bruce.ashfield@gmail.com>

On Mon, Nov 24, 2025 at 1:35=E2=80=AFPM Ross Burton <ross.burton@arm.com> w=
rote:

> Use KERNEL_SRC to specify the location of the kernel source tree, to
> match module.bbclass in OpenEmbedded Core.
>
> Also add a modules_install target.
>
> Signed-off-by: Ross Burton <ross.burton@arm.com>
> ---
>  Makefile | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index e357001..b6fa870 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1,11 +1,12 @@
> -KERNELRELEASE  ?=3D `uname -r`
> -KERNEL_DIR     ?=3D /lib/modules/$(KERNELRELEASE)/build
> -PWD            :=3D $(shell pwd)
> -obj-m          :=3D hello-world.o
> +obj-m      :=3D hello-world.o
> +KERNEL_SRC ?=3D /lib/modules/$(shell uname -r)/build
> +SRC        :=3D $(shell pwd)
>
>  all:
> -       @echo "Building hello-world kernel module..."
> -       $(MAKE) -C $(KERNEL_DIR) M=3D$(PWD) modules
> +       $(MAKE) -C $(KERNEL_SRC) M=3D$(SRC) modules
> +
> +modules_install:
> +       $(MAKE) -C $(KERNEL_SRC) M=3D$(SRC) modules_install
>
>  clean:
> -       make -C $(KERNEL_DIR) M=3D$(PWD) clean
> +       make -C $(KERNEL_SRC) M=3D$(PWD) clean
> --
> 2.43.0
>
>

--=20
- Thou shalt not follow the NULL pointer, for chaos and madness await thee
at its end
- "Use the force Harry" - Gandalf, Star Trek II

--00000000000078940806445c484d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_default" style=3D"font-size:small">Ack=
ed-by: Bruce Ashfield &lt;<a href=3D"mailto:bruce.ashfield@gmail.com">bruce=
.ashfield@gmail.com</a>&gt;</div></div><br><div class=3D"gmail_quote gmail_=
quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Nov 24, 2025=
 at 1:35=E2=80=AFPM Ross Burton &lt;<a href=3D"mailto:ross.burton@arm.com">=
ross.burton@arm.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quot=
e" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204)=
;padding-left:1ex">Use KERNEL_SRC to specify the location of the kernel sou=
rce tree, to<br>
match module.bbclass in OpenEmbedded Core.<br>
<br>
Also add a modules_install target.<br>
<br>
Signed-off-by: Ross Burton &lt;<a href=3D"mailto:ross.burton@arm.com" targe=
t=3D"_blank">ross.burton@arm.com</a>&gt;<br>
---<br>
=C2=A0Makefile | 15 ++++++++-------<br>
=C2=A01 file changed, 8 insertions(+), 7 deletions(-)<br>
<br>
diff --git a/Makefile b/Makefile<br>
index e357001..b6fa870 100644<br>
--- a/Makefile<br>
+++ b/Makefile<br>
@@ -1,11 +1,12 @@<br>
-KERNELRELEASE=C2=A0 ?=3D `uname -r`<br>
-KERNEL_DIR=C2=A0 =C2=A0 =C2=A0?=3D /lib/modules/$(KERNELRELEASE)/build<br>
-PWD=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 :=3D $(shell pwd)<br>
-obj-m=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 :=3D hello-world.o<br>
+obj-m=C2=A0 =C2=A0 =C2=A0 :=3D hello-world.o<br>
+KERNEL_SRC ?=3D /lib/modules/$(shell uname -r)/build<br>
+SRC=C2=A0 =C2=A0 =C2=A0 =C2=A0 :=3D $(shell pwd)<br>
<br>
=C2=A0all:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0@echo &quot;Building hello-world kernel module.=
..&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0$(MAKE) -C $(KERNEL_DIR) M=3D$(PWD) modules<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0$(MAKE) -C $(KERNEL_SRC) M=3D$(SRC) modules<br>
+<br>
+modules_install:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0$(MAKE) -C $(KERNEL_SRC) M=3D$(SRC) modules_ins=
tall<br>
<br>
=C2=A0clean:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0make -C $(KERNEL_DIR) M=3D$(PWD) clean<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0make -C $(KERNEL_SRC) M=3D$(PWD) clean<br>
-- <br>
2.43.0<br>
<br>
</blockquote></div><div><br clear=3D"all"></div><div><br></div><span class=
=3D"gmail_signature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_s=
ignature">- Thou shalt not follow the NULL pointer, for chaos and madness a=
wait thee at its end<br>- &quot;Use the force Harry&quot; - Gandalf, Star T=
rek II<br><br></div>

--00000000000078940806445c484d--

