Return-Path: <mathieu.dubois-briand@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C609EE4994
	for <webhook@archiver.kernel.org>; Tue, 30 Dec 2025 17:52:54 +0000 (UTC)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.69020.1767117170109346334
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 30 Dec 2025 09:52:50 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=AfyMxom6;
 spf=pass (domain: bootlin.com, ip: 185.171.202.116, mailfrom: mathieu.dubois-briand@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 43D53C1D73D
	for <yocto-patches@lists.yoctoproject.org>; Tue, 30 Dec 2025 17:52:22 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 8CC486072C
	for <yocto-patches@lists.yoctoproject.org>; Tue, 30 Dec 2025 17:52:47 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 259FD113B029B;
	Tue, 30 Dec 2025 18:52:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1767117166; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=TnuW6E6KDeGOCPmzodWzXwkJ+y/0BXoRdt80BdjNvkg=;
	b=AfyMxom6vWcVOUv1eZQ9lxNa0ojUVdAWDkpkSuRgtBKklriNJwtRpbfqhxEGf7JZKVS9o9
	kTWKaViq2OqzgnKT6EG5bhaDWsPPfi5KVvGjBq7SxgkJd3EOUr3May7Vh4KjhQ7bXdow6O
	ao/8ljbO+0b20xqEP78bKIh9PJgKlQ0d1p9r6Bqs8y5YDveeFgm3RzK1mQvtOSMeXVjctq
	WxeY/k1PuAGUmFqIIjVxY+VGIeJtvMvgdy28cvfzk6iu+Dgb0Jcz4mBsnDhQG1OpPNy/nj
	pjUvTY9Ug16UEybqsZPwOXgPXApGZqJ4/pSB8uE3t+ymEfqUMsHg+FX5t2j6PQ==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 30 Dec 2025 18:52:44 +0100
Message-Id: <DFBQR66V6YOM.PJP8GGZ0LFXD@bootlin.com>
From: "Mathieu Dubois-Briand" <mathieu.dubois-briand@bootlin.com>
To: <yocto-patches@lists.yoctoproject.org>
Subject: Re: [yocto-patches] [PATCH yocto-autobuilder-helper] send_qa_email:
 Only copy logs when we are pushing tags
Cc: "Thomas Petazzoni" <thomas.petazzoni@bootlin.com>
X-Mailer: aerc 0.19.0-0-gadd9e15e475d
References: <18860F6D49E68295.1706869@lists.yoctoproject.org>
In-Reply-To: <18860F6D49E68295.1706869@lists.yoctoproject.org>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 30 Dec 2025 17:52:54 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2886

On Tue Dec 30, 2025 at 6:47 PM CET, Mathieu Dubois-Briand via lists.yoctopr=
oject.org wrote:
> Resulttool creates tags in yocto-testresults and copies logs in an NFS
> shared folder whose name is based on this tag. If we are never going to
> push this tag, we should not copy the logs, in order to maintain some
> coherency.
>
> Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
> ---
>  scripts/send_qa_email.py | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/scripts/send_qa_email.py b/scripts/send_qa_email.py
> index 23114a47da11..2755df9f30f7 100755
> --- a/scripts/send_qa_email.py
> +++ b/scripts/send_qa_email.py
> @@ -203,7 +203,15 @@ def send_qa_email():
>              utils.printheader("Storing results")
> =20
>              if not args.dry_run:
> -                subprocess.check_call([resulttool, "store", "--revision"=
, revision, "-l", args.results_dir + "/../../testresult-logarchives" , args=
.results_dir, tempdir])
> +                cmd =3D [resulttool, "store", "--revision", revision, ar=
gs.results_dir, tempdir]
> +
> +                # Ask resulttool to store logs in log archive folder. We=
 should
> +                # only do this when tags are pushed, as tags and log fol=
der have
> +                # to match.
> +                if basebranch or targetbranch:
> +                    cmd.extend(["-l", args.results_dir + "/../../testres=
ult-logarchives"])
> +
> +                subprocess.check_call(cmd)
>                  if basebranch:
>                      subprocess.check_call(["git", "push", "--all", "--fo=
rce"], cwd=3Dtempdir)
>                      subprocess.check_call(["git", "push", "--tags", "--f=
orce"], cwd=3Dtempdir)
>
> ---
> base-commit: 6f793956c9b43f7a74f5a22c86a93b744b21ada9
> change-id: 20251230-mathieu-fix-15696-788af5e206c5
>
> Best regards,

This raises another question: it it useful to call `resulttool store` at
all, we we are not going to push the yocto-testresults git afterwards?
I'm not sure it makes sense.

--=20
Mathieu Dubois-Briand, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


