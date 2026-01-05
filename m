Return-Path: <t.f.g.geelen@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42D34CD0423
	for <webhook@archiver.kernel.org>; Mon,  5 Jan 2026 22:58:24 +0000 (UTC)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.77859.1767653894613996991
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 05 Jan 2026 14:58:14 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=btduoVCF;
 spf=pass (domain: gmail.com, ip: 209.85.167.53, mailfrom: t.f.g.geelen@gmail.com)
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-59b30275e69so22052e87.1
        for <yocto-patches@lists.yoctoproject.org>; Mon, 05 Jan 2026 14:58:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767653892; x=1768258692; darn=lists.yoctoproject.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cso1+frjkR0DxwIaMkBsUDV5qLMouuzWngIXpV1SI40=;
        b=btduoVCF1wCzpHdm9vr3jYKbg+PIZpzsQJnjxQ+2oVjLwTVUQHCC2nKU36k73tZcrN
         Jk/j648mTIExJXYvkExFjhWmrKot8FDg8MmIr9IOPISJVa6VsYbnsXKATqG6DMfcjmfJ
         LGf1asCdV7KgpvAKx/afZoMlhGBMsYsKECivHEfHWOQZs+eyXcqCsgBOxm3Ag0FzbeKT
         2i0ZzVYL32wJJotS8P4bHc3xV30inUGUidzUnxqgHD1AxyWlfMaJ2lUF68ubhHjqYPxD
         r+cRy2/AXJDOKuqU40VeoO2rj6Uvev/G/EH/uzDPiex5bgnXeHex8TwnIm4/RE68MByZ
         GDyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767653892; x=1768258692;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cso1+frjkR0DxwIaMkBsUDV5qLMouuzWngIXpV1SI40=;
        b=Cv8Ba+ExS8uFEIFBJh3b+sFIRilVB2XiAu0zwaWjv1RSbITL7tv7Z27hFBTJxkCBOP
         rzgYS4PaI+FHSpmWfnQEMibz3VzhdOpEaon4Sm+shllDwo4SsX4XZH3AzKhz5IJ8WGwY
         zslJIsA8fJ/sMjxYTx9d6xfuFrWuwB/lDBXiEkxzUUA1KlNNedO+ngGPAtW0lzsClFUN
         v6m1GJF0A4iZ06FNrjTiA7U16sosB9/2eIpVsFA/NDwI5Nczml5xBBwlPqkPJxDKRdX0
         I5EbVQAfXmyYBqavwykEXeOze17EqNr55c7lbhQ2np8/Z7h+azagLq3eEge/vAPTxBIc
         Rd6g==
X-Gm-Message-State: AOJu0YzaiJCDH0RjYekI3r8h1X1wwfRYuLZo7M4PsZU0r1UIhWDq9YmN
	TbVdG01wgkoQN3GM6dhQoeyfA9Gqbwsb/dgsT0jqIWQC1ZjN86APIYdm/hlCCiIJ6u9Ty+k8Zwe
	2yTsdD4UofGZtRlrEl/CK1/2O2zdSp4YszOeb
X-Gm-Gg: AY/fxX7EtbKUJ3bDiioU53mZ70huZJf2dOftqzVLo5Zo8fyhb2uZG0qq7ZN9E/XR0tp
	rvu1dQymLQcR3Fb2SqRx3mHl/NKm7CQDwhJzNT99w+ApzDtb0jCH1GUwXNlofJqr3ZprQRzH6sn
	bAkCk+dgAaqyz12k59cYnuxEYJLpvICokVLukmHTDB6RqTfQ7kGBy33DMJToDlYILwk75V4VzZ8
	mKenoLcdQRY7uG+a4wquEN5+Kez3HDWVW8EbaO0vVJpUYvOXa5GLCE6UZ7qXPWNdmdwHA==
X-Google-Smtp-Source: AGHT+IFBFF99tLJw/z/VoLUBVj9UHXfKvDaiOJc61BnHVb4jVfdXHXBcQtZqFPURHlvqr6GwdfSZEH6Tw3GGrx7xpBc=
X-Received: by 2002:a05:6512:3c9c:b0:59a:107a:45a5 with SMTP id
 2adb3069b0e04-59b6522822emr359292e87.23.1767653891616; Mon, 05 Jan 2026
 14:58:11 -0800 (PST)
MIME-Version: 1.0
From: Tom Geelen <t.f.g.geelen@gmail.com>
Date: Mon, 5 Jan 2026 23:58:01 +0100
X-Gm-Features: AQt7F2q7HF4NjPUjzV9QQ3Qp35PHbhZVEbmEDZe6glSkFi-r8UhYFjvWappF250
Message-ID: <CAJo0Az7nERXq4M8Lk+hwjqnBA8uUDXgy4EDGhOj3wYJ2=4y8Hw@mail.gmail.com>
Subject: [auh] New Patches
To: yocto-patches@lists.yoctoproject.org
Cc: Alexander Kanavin <alex.kanavin@gmail.com>
Content-Type: multipart/alternative; boundary="0000000000004bb15e0647abfe5b"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 05 Jan 2026 22:58:24 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2899

--0000000000004bb15e0647abfe5b
Content-Type: text/plain; charset="UTF-8"

Hi Alex,

*Nothing to commit problem*
I have proposed a simple solution for the problem you mentioned. It still
raises e normally in commit_changes except for the case when there is
nothing to commit.

I tested it with the recipes lua (which fails to compile) and perlcross
(which has a full devtool failure) and now the results are what you would
expect. (see below)

INFO: ########### The list of recipes to be upgraded #############
INFO: , perlcross, 1.6.2, 1.6.4, Unassigned <unassigned@yoctoproject.org>,
N/A
INFO: ############################################################
INFO: Building gcc runtimes ...
INFO:  building gcc runtime for qemux86-64
INFO: ATTEMPT PACKAGE GROUP 1/1
INFO: perlcross: Upgrading to 1.6.4
INFO: perlcross: Loading environment ...
INFO: perlcross: Running 'devtool upgrade' ...
ERROR: perlcross: The following devtool command failed:  upgrade perlcross
-V 1.6.4
INFO: perlcross: Auto commit changes ...
INFO: perlcross: nothing to commit
INFO: Generating work tarball in
/home/tom/projects/meta-sanctum/build-homeassistant/build/upgrade-helper/20260105215203.tar.gz
...
INFO: Recipe upgrade statistics:

    * Failed (devtool error): 1
        perlcross, 1.6.4, Unassigned <unassigned@yoctoproject.org>

    TOTAL: attempted=1 succeeded=0(0.00%) failed=1(100.00%)

*error reported as success*
I have resubmitted this one, as even with the above fix that problem is
still there as I believe they are also not related per se. This problem
arises when one tries to call AUH on a recipe on a non-core repo and it
will go through the AUH steps correctly but on committing it will fail as
the git root is automatically set to the core layer, instead of using the
layer the recipe is actually located. With this adjustment at least now
there are no false positives generated anymore.

I'm working on detection method for recipes so git is used in the correct
repo.

Regards,

Tom

--0000000000004bb15e0647abfe5b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Alex,<br><br><b>Nothing to commit problem</b><br>I have=
 proposed a simple solution for the problem you mentioned. It still raises =
e normally in commit_changes except for the case when there is nothing to c=
ommit.<br><br>I tested it with the recipes lua (which fails to compile) and=
 perlcross (which has a full devtool failure) and now the results are what =
you would expect. (see below)<br><br>INFO: ########### The list of recipes =
to be upgraded #############<br>INFO: , perlcross, 1.6.2, 1.6.4, Unassigned=
 &lt;<a href=3D"mailto:unassigned@yoctoproject.org">unassigned@yoctoproject=
.org</a>&gt;, N/A<br>INFO: ################################################=
############<br>INFO: Building gcc runtimes ...<br>INFO: =C2=A0building gcc=
 runtime for qemux86-64<br>INFO: ATTEMPT PACKAGE GROUP 1/1<br>INFO: perlcro=
ss: Upgrading to 1.6.4<br>INFO: perlcross: Loading environment ...<br>INFO:=
 perlcross: Running &#39;devtool upgrade&#39; ...<br>ERROR: perlcross: The =
following devtool command failed: =C2=A0upgrade perlcross -V 1.6.4<br>INFO:=
 perlcross: Auto commit changes ...<br>INFO: perlcross: nothing to commit<b=
r>INFO: Generating work tarball in /home/tom/projects/meta-sanctum/build-ho=
meassistant/build/upgrade-helper/20260105215203.tar.gz ...<br>INFO: Recipe =
upgrade statistics:<br><br>=C2=A0 =C2=A0 * Failed (devtool error): 1<br>=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 perlcross, 1.6.4, Unassigned &lt;<a href=3D"mailto=
:unassigned@yoctoproject.org">unassigned@yoctoproject.org</a>&gt;<br><br>=
=C2=A0 =C2=A0 TOTAL: attempted=3D1 succeeded=3D0(0.00%) failed=3D1(100.00%)=
<div><br></div><div><b>error reported as success</b></div><div>I have resub=
mitted this one, as even with the above fix that problem is still there as =
I believe they are also not related per se. This problem arises when one tr=
ies to call AUH on a recipe on a non-core repo and it will go through the A=
UH steps correctly but on committing it will fail as the git root is automa=
tically set to the core layer, instead of using the layer the recipe is act=
ually located. With this adjustment at least now there are no false positiv=
es generated anymore.</div><div><br></div><div>I&#39;m working on detection=
 method for recipes so git is used in the correct repo.</div><div><br></div=
><div>Regards,</div><div><br></div><div>Tom</div></div>

--0000000000004bb15e0647abfe5b--

