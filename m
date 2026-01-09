Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADD9BD26D91
	for <webhook@archiver.kernel.org>; Fri,  9 Jan 2026 18:30:51 +0000 (UTC)
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.16895.1767983445023761144
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 09 Jan 2026 10:30:45 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=K64DdaCP;
 spf=pass (domain: konsulko.com, ip: 209.85.160.182, mailfrom: scott.murray@konsulko.com)
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4ed7024c8c5so36708051cf.3
        for <yocto-patches@lists.yoctoproject.org>; Fri, 09 Jan 2026 10:30:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1767983444; x=1768588244; darn=lists.yoctoproject.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=i76PGegnPB8p26AOpkCq4UKes97jIocPIfjuF0w75qI=;
        b=K64DdaCPVsyhPMaWINgukQUqHm8FplFdpO709UmsI+2X9QPpp4+qAw6TyCJlU9EIo6
         klToIeBlbXaHSjgkwvppCakYunkY6dEyNyVVNs2JAUWz6yYJrIXQt0gB+nVUKHWCGfXK
         nylEu9JQPCMieMetj49iAh4sbTDFJNdpHLe5M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767983444; x=1768588244;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i76PGegnPB8p26AOpkCq4UKes97jIocPIfjuF0w75qI=;
        b=telo30KHdi20ZI60swA4RtGlqFvszadNbKeuOmXcm/AYfplcEWHoM97v43ym1AFs6o
         udpm2npqinqbS3ryJ1I+Q9kVZaxsxxXGRjW0LV5V+G6MDUupFMRSvd4rFWihC5ASMMC2
         FR2lK3WSE9BeH82RHFFm2oK8bJ3+JiZJNLt77WsOkCNlH+6+dhWrB6LC/yWKukv6hY0u
         xcIiLIq2rVmBK8J0M/FzkPVO9Xk5qJdMRK0jyj2zfucnXH2B6S0LZqa597/Vm+iYB/v8
         WrB1gGk+SLIlUpKsWGhJ1o0t5O3vw5yrb6q+AjMq5fvnPT3o1l8fcqGUtd5Len5ph0lK
         a0Pw==
X-Gm-Message-State: AOJu0YymJ3XC57oulSP30aoMQ9iIQ5MAHj5KAscETqHhkRhex6aUO58B
	726zD0A39WwuxBA/VQkjXxSFxupBEP60Rw0DYc69J0JmMshqRnnXndrasmLUKOvVVmo=
X-Gm-Gg: AY/fxX7Dq5f6z8++AhcqqYlRn6rr99+h/687p/S7mPc0zqNniTDq5hqw8kwMsRwolZa
	gqpVA4c9IZQbB538eARX1JApLaKocwLfRrKTBszcKN1iPL5SqFWM5a6dFjDOdmJblZ/pNH+m0Bl
	OtYMiYygRofApCp/GOiee0e2Yn3Thoj03Kqrm9R5S9T55cO28LQtL2vDKYZi/yPz0ew7DqtAQbk
	JdYI1KhAgnoRBEEhXPFSeXqOen5EUY8yBfsBzZB1LSJbmXGlOK1ttgv7Gox841Z5ELwg7ixxKjk
	tU9Yk8YL5IOTpSK/WO4gNMn9BC+c8IGRISWKVXsdaVclmKtebg7gyQtzLP2PIb31QMzX6O9ghlH
	9WfnfjbuYZpT2Z7RH/cec/ce0b7f5lwAnYfEO84n5E8BPSOEi+YE1KUg5+z2ZqvSXg4xSgxI9f1
	knP20kInhhhwd8q1B/9folPObenMnWameXndznx2GMKGG1l186alontlDRk3e29eeAN/QHfXOGL
	wg1gDBLeqFcWQJMRqGg5e1N1pnWsiOZOEY=
X-Google-Smtp-Source: AGHT+IEDx/RQAEkpF/2IqIZGjuzVdN2Xw/waD3H2sQK5x9urahO35oqS4WNgLOFj0SjDW6sQol0Z6w==
X-Received: by 2002:ac8:5a47:0:b0:4ec:f84d:cb40 with SMTP id d75a77b69052e-4ffb4a3ec38mr135099531cf.44.1767983443552;
        Fri, 09 Jan 2026 10:30:43 -0800 (PST)
Received: from godzilla (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ffa8e4c810sm76250351cf.24.2026.01.09.10.30.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 10:30:43 -0800 (PST)
Date: Fri, 9 Jan 2026 13:30:42 -0500 (EST)
From: Scott Murray <scott.murray@konsulko.com>
To: Vijay Anusuri <vanusuri@mvista.com>
cc: yocto-patches@lists.yoctoproject.org
Subject: Re: [meta-security][kirkstone][PATCH] sssd: Fix for CVE-2025-11561
In-Reply-To: <CANQUz19gBo=0VHCRMPYRqHLn8Cvw5V5u6F4SPcKFYMSJsxRoVA@mail.gmail.com>
Message-ID: <b06f688f-4622-f42d-3b82-3549e8f14c50@konsulko.com>
References: <20251205101051.171885-1-vanusuri@mvista.com> <CANQUz19gBo=0VHCRMPYRqHLn8Cvw5V5u6F4SPcKFYMSJsxRoVA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="-1463811583-888252922-1767983443=:3481"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 09 Jan 2026 18:30:51 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2927

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463811583-888252922-1767983443=:3481
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Fri, 9 Jan 2026, Vijay Anusuri wrote:

> Hi Team,
>
> Any Update on this ?
>
> Thanks & Regards,
> Vijay

My apologies, kirkstone and scarthgap branch updates have been delayed due
to travel on my part in early December followed by the holidays.  I'm
aiming to push out updates for them in the next few days.

Scott


> On Fri, Dec 5, 2025 at 3:41 PM <vanusuri@mvista.com> wrote:
>
> > From: Vijay Anusuri <vanusuri@mvista.com>
> >
> > Upstream-Status: Backport [
> > https://github.com/SSSD/sssd/commit/a0336f4cd69c25b3d501a3d361d3d286c00da4d2
> > ]
> >
> > Signed-off-by: Vijay Anusuri <vanusuri@mvista.com>
> > ---
> >  .../sssd/files/CVE-2025-11561.patch           | 50 +++++++++++++++++++
> >  recipes-security/sssd/sssd_2.5.2.bb           |  1 +
> >  2 files changed, 51 insertions(+)
> >  create mode 100644 recipes-security/sssd/files/CVE-2025-11561.patch
> >
> > diff --git a/recipes-security/sssd/files/CVE-2025-11561.patch
> > b/recipes-security/sssd/files/CVE-2025-11561.patch
> > new file mode 100644
> > index 0000000..0bfed6d
> > --- /dev/null
> > +++ b/recipes-security/sssd/files/CVE-2025-11561.patch
> > @@ -0,0 +1,50 @@
> > +From a0336f4cd69c25b3d501a3d361d3d286c00da4d2 Mon Sep 17 00:00:00 2001
> > +From: Sumit Bose <sbose@redhat.com>
> > +Date: Fri, 10 Oct 2025 12:57:40 +0200
> > +Subject: [PATCH] krb5: disable Kerberos localauth an2ln plugin for AD/IPA
> > +MIME-Version: 1.0
> > +Content-Type: text/plain; charset=UTF-8
> > +Content-Transfer-Encoding: 8bit
> > +
> > +If a client is joined to AD or IPA SSSD's localauth plugin can handle
> > +the mapping of Kerberos principals to local accounts. In case it cannot
> > +map the Kerberos principals libkrb5 is currently configured to fall back
> > +to the default localauth plugins 'default', 'rule', 'names',
> > +'auth_to_local', 'k5login' and 'an2ln' (see man krb5.conf for details).
> > +All plugins except 'an2ln' require some explicit configuration by either
> > +the administrator or the local user. To avoid some unexpected mapping is
> > +done by the 'an2ln' plugin this patch disables it in the configuration
> > +snippets for SSSD's localauth plugin.
> > +
> > +Resolves: https://github.com/SSSD/sssd/issues/8021
> > +
> > +:relnote: After startup SSSD already creates a Kerberos configuration
> > + snippet typically in /var/lib/sss/pubconf/krb5.include.d/localauth_plugin
> > + if the AD or IPA providers are used. This enables SSSD's localauth
> > plugin.
> > + Starting with this release the an2ln plugin is disabled in the
> > + configuration snippet as well. If this file or its content are included
> > in
> > + the Kerberos configuration it will fix CVE-2025-11561.
> > +
> > +Reviewed-by: Alexey Tikhonov <atikhono@redhat.com>
> > +Reviewed-by: Pavel Březina <pbrezina@redhat.com>
> > +(cherry picked from commit 9939c39d1949fad48af2f0b43c788bad0809e310)
> > +
> > +Upstream-Status: Backport [
> > https://github.com/SSSD/sssd/commit/a0336f4cd69c25b3d501a3d361d3d286c00da4d2
> > ]
> > +CVE: CVE-2025-11561
> > +Signed-off-by: Vijay Anusuri <vanusuri@mvista.com>
> > +---
> > + src/util/domain_info_utils.c | 1 +
> > + 1 file changed, 1 insertion(+)
> > +
> > +diff --git a/src/util/domain_info_utils.c b/src/util/domain_info_utils.c
> > +index e131a5d96af..160e1711bcd 100644
> > +--- a/src/util/domain_info_utils.c
> > ++++ b/src/util/domain_info_utils.c
> > +@@ -751,6 +751,7 @@ static errno_t sss_write_krb5_snippet_common(const
> > char *file_name,
> > + #define LOCALAUTH_PLUGIN_CONFIG \
> > + "[plugins]\n" \
> > + " localauth = {\n" \
> > ++"  disable = an2ln\n" \
> > + "  module = sssd:"APP_MODULES_PATH"/sssd_krb5_localauth_plugin.so\n" \
> > + " }\n"
> > +
> > diff --git a/recipes-security/sssd/sssd_2.5.2.bb b/recipes-security/sssd/
> > sssd_2.5.2.bb
> > index c07559c..43c31ee 100644
> > --- a/recipes-security/sssd/sssd_2.5.2.bb
> > +++ b/recipes-security/sssd/sssd_2.5.2.bb
> > @@ -25,6 +25,7 @@ SRC_URI = "
> > https://github.com/SSSD/sssd/releases/download/${PV}/sssd-${PV}.tar.g
> >             file://musl_fixup.patch \
> >             file://CVE-2021-3621.patch \
> >             file://CVE-2023-3758.patch \
> > +           file://CVE-2025-11561.patch \
> >             "
> >
> >  SRC_URI[sha256sum] =
> > "5e21b3c7b4a2f1063d0fbdd3216d29886b6eaba153b44fb5961698367f399a0f"
> > --
> > 2.25.1
> >
> >
>
---1463811583-888252922-1767983443=:3481--

