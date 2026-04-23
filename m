Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87A7FFAD41E
	for <webhook@archiver.kernel.org>; Thu, 23 Apr 2026 06:12:48 +0000 (UTC)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.13749.1776924763415154145
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 22 Apr 2026 23:12:43 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=FJlmYYHo;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.52, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-488ab2db91aso83170155e9.3
        for <yocto-patches@lists.yoctoproject.org>; Wed, 22 Apr 2026 23:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1776924761; x=1777529561; darn=lists.yoctoproject.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B62t4tHnT9rbXTXQBFOkQxXXKEWbdM+BiZkTGdAHxb0=;
        b=FJlmYYHoIagiSnSYZPU8wQEUnhkSLE1+uwJrILSnorDzbyU1MG5lfwO1nr6M9cO8Ga
         PRbfKEBGstweg6XEg2MONyBMXabRXM+7TwKCVgpdGgyPuhTf774Foi9J4loHkD7YZiwM
         owMSZ5MhxHEoMsjmzwHMRMTzvwhcLSZ4G391s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776924761; x=1777529561;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B62t4tHnT9rbXTXQBFOkQxXXKEWbdM+BiZkTGdAHxb0=;
        b=USLtI3IhMn96LFS5Yet1wn3cx+4fnEM4vul0oc/xxUtsY6mgjkXOORxGZTmFwf6CK6
         0T1n+i4unhTYxnX00Wpu0Dd83mihlLJidtNbqO8XxyHe4AJxFDtHaTCV0FJU6rH/mU4S
         kue30ZfSejbFIW4uKd9F8VAZP3QtF72BZXCbeN6FSM6REHJPc3/IQZOJPaEVCk7+Xkf9
         KKAubPST8oMIBenKd7dR6T8A9EoPq8wQqz9Nl2Bj3bcCMQ9sG6wqcbsoeNev2TTn3uFo
         pASs5n2uWWW9bkflWHJjbkLWwY6N50pW9lA/Pt3uhEBUYlxoRD3iBhpY6kyJ8Ka4p116
         tH5w==
X-Gm-Message-State: AOJu0Yw47Iuj9w1Hv1tCLJ6F/pbKJUyI8gmQq343zuZ3yuZny4d9RVKX
	Cb1uGv9T7GgDt1VuahQcqSJlsujtfnDlygeJW93jbA6c8iGT7Mp1vPQ7oJQykpR7/klt6V40SzP
	vyLxPf2M=
X-Gm-Gg: AeBDiev/iKnfu98WAFAiwiujmh8wqaZEnmtoWeqx7TEPS5ScLTjeHR3ox9g0cqqZla/
	9yDg7DSiShJ3MdnLAp83H0snE3vhsn3cOid7hBRwDPkvxlYu2I0w+Mq4TAhPCWY91H0IAvi4kUY
	2gKM3bHei9TG4wK37Vvmfy4GJvDIQXUYaOeIsMpkQwpznFrVSnTGq/Ha6JGKuVZ9Xxv2HydxL8H
	g3fIuID9KmXR6G1cM1JPTSUbFAPEwHb6N0f7u18DEQBcck/vPNAHKjhhygyNGIfjD7J9Wva0jF/
	Etwtd4jndqprOOV2ptK3057q81hliO2fyj0dY69yFVB8xun0n8ya5n9EjypgUycC9u+HGDaGksr
	5K4SXILRRy28HCImWeZfKPea4rCESN/BBOuxWRct3T44A4jQCOT8VeAymwAgZt1sE/hhXQeEmam
	hNup8UTQY64ib429TyRSpzTwmkLO9kpdOZAtUTguyjC9mMELpTnaf7uLYa/IUG2ve+YbfKkaYDC
	IY5sxMar5OqWQLEpOM3Qzt5gsc=
X-Received: by 2002:a05:600c:c10e:b0:488:8185:e672 with SMTP id 5b1f17b1804b1-488fb792e84mr280011945e9.30.1776924761097;
        Wed, 22 Apr 2026 23:12:41 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:8228:dac2:8992:4ae8? ([2001:8b0:aba:5f3c:8228:dac2:8992:4ae8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a575ad67asm141765285e9.2.2026.04.22.23.12.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 23:12:40 -0700 (PDT)
Message-ID: <a0772e3cd3ba1ca5f983ba4d1702d3b2e557e373.camel@linuxfoundation.org>
Subject: Re: [yocto-patches] [pseudo] [PATCH] Only copy xattrs on a rename
 if it's cross-filesystem
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: yocto-patches@lists.yoctoproject.org, Mark Hatle
	 <mark.hatle@kernel.crashing.org>
Date: Thu, 23 Apr 2026 07:12:38 +0100
In-Reply-To: <e33ab7a4-d154-40ec-bd63-a60714d65a86@linux.microsoft.com>
References: <189BDB418FBB5474.2478623@lists.yoctoproject.org>
	 <18A4662FFC3AFB17.657799@lists.yoctoproject.org>
	 <e33ab7a4-d154-40ec-bd63-a60714d65a86@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-9 
MIME-Version: 1.0
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 23 Apr 2026 06:12:48 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3772

On Wed, 2026-04-22 at 09:26 -0400, Daniel Burgener via lists.yoctoproject.o=
rg wrote:
> On 4/8/2026 9:55 AM, Daniel Burgener via lists.yoctoproject.org wrote:
> > On 3/11/2026 1:59 PM, Daniel Burgener via lists.yoctoproject.org wrote:
> > > On same file-system renames, the path update in the db means that the
> > > xattrs are already present, and copying results in duplicates.=C2=A0 =
This was
> > > previously masked by the bug fixed in=20
> > > d1db9c219abf92f15303486a409292237f1fc790, since that prevented the
> > > xattr copying.=C2=A0 Now that that bug is fixed, we started observing=
 this
> > > issue in 1.9.3.
> > >=20
> > > AI-Generated: Code fix by Claude Haiku 4.5.=C2=A0 Test code by me.
> > >=20
> > > Signed-off-by: Daniel Burgener <dburgener@linux.microsoft.com>
> > > ---
> > > =C2=A0 pseudo_db.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 =
4 +++-
> > > =C2=A0 test/test-xattr.sh | 12 ++++++++++++
> > > =C2=A0 2 files changed, 15 insertions(+), 1 deletion(-)
> > >=20
> > > diff --git a/pseudo_db.c b/pseudo_db.c
> > > index 9713e0c..6a33f20 100644
> > > --- a/pseudo_db.c
> > > +++ b/pseudo_db.c
> > > @@ -2196,7 +2196,9 @@ pdb_update_inode(pseudo_msg_t *msg) {
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 found_existing =3D !pdb_find_file_path=
(oldmsg);
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (found_existing) {
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* we have an =
existing file entry */
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pdb_copy_xattrs(oldmsg, m=
sg);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (oldmsg->dev !=3D msg-=
>dev || oldmsg->ino !=3D msg->ino) {
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 p=
db_copy_xattrs(oldmsg, msg);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sqlite3_bind_int(update, 1, msg->dev);
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sqlite3_bind_int64(update, 2, signed_i=
no(msg->ino));
> > > diff --git a/test/test-xattr.sh b/test/test-xattr.sh
> > > index 6ac6b3c..89fbd35 100755
> > > --- a/test/test-xattr.sh
> > > +++ b/test/test-xattr.sh
> > > @@ -65,6 +65,18 @@ then
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 exit 1
> > > =C2=A0 fi
> > > +mv f1 f2
> > > +attrs=3D`getfattr -d -m - f2 | grep -v '^#'`
> > > +expected=3D$'security.dummy=3D"test_f2"\nuser.dummy=3D"test_f1"'
> > > +if [ "$attrs" !=3D "$expected" ]
> > > +then
> > > +=C2=A0=C2=A0=C2=A0 #echo "Fail, unpexected getfattr result '$attrs'"
> > > +=C2=A0=C2=A0=C2=A0 rm -f f1
> > > +=C2=A0=C2=A0=C2=A0 rm -f f2
> > > +=C2=A0=C2=A0=C2=A0 exit 1
> > > +fi
> > > +
> > > =C2=A0 #echo "Passed."
> > > =C2=A0 rm -f f1
> > > +rm -f f2
> > > =C2=A0 exit 0
> >=20
> > Gentle ping on this patch.=C2=A0 Any feedback?
> >=20
> > -Daniel
> >=20
>=20
> Pinging again on this.=C2=A0 If I've done something wrong in submitting,=
=20
> please let me know so I can get this reviewed.
>=20
> I'll also note that while I did use AI for the fix, this is an actual
> bug we're encountering in our environment, not something picked up by an=
=20
> LLM scanning the code base.=C2=A0 Specifically, we (in a pseudo environme=
nt)=20
> populate a directory structure, and then do:
>=20
> setfiles -m -v -E -F ${FILE_CONTEXTS} -r ${FOO_SQUASHFS_ROOT}=20
> ${FOO_SQUASHFS_ROOT}
> mksquashfs "$FOO_SQUASHFS_ROOT" "$PATH_FOO" -noappend
> # mv some files into ${FOO_SQUASHFS_ROOT}
> setfiles -m -v -E -F ${FILE_CONTEXTS} -r ${FOO_SQUASHFS_ROOT}
> mksquashfs "$FOO_SQUASHFS_ROOT" "$PATH_BAR" -noappend
>=20
> We observe the second mksquashfs fail due to duplicate selinux xattrs.=
=20
> My understanding is that the code touched in this patch seems to rename=
=20
> the original file, which preserves the xattrs in the pseudodb, and then=
=20
> copy the xattrs as well, resulting in duplicate xattrs.

Sorry about the delay, we've been struggling a bit for review cycles. I
think this looks right to me. Copying Mark to see what he thinks.

Cheers,

Richard

