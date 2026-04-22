Return-Path: <dburgener@linux.microsoft.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4729BF9EDCD
	for <webhook@archiver.kernel.org>; Wed, 22 Apr 2026 13:26:19 +0000 (UTC)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.82433.1776864369266796063
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 22 Apr 2026 06:26:09 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@linux.microsoft.com header.s=default header.b=BAzJEeOq;
 spf=pass (domain: linux.microsoft.com, ip: 13.77.154.182, mailfrom: dburgener@linux.microsoft.com)
Received: from [100.96.32.167] (unknown [52.167.112.163])
	by linux.microsoft.com (Postfix) with ESMTPSA id C2C9A20B6F01
	for <yocto-patches@lists.yoctoproject.org>; Wed, 22 Apr 2026 06:26:08 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C2C9A20B6F01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1776864368;
	bh=LTAgOI2Mi4Q/ii156Ivtjnyd36I35Rcrcc2uNxACyu0=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=BAzJEeOqYmefQmOtxvsES18FgjkTGE9iC8fRLY60On6qcPu3oN/oR5k7Ysxro8xwS
	 4navtc8FiqgoHzGxlhqxonWT8TU9yYsxM3P7HkidwmkVyUrqjGoHJcYdf7aeLXdivZ
	 ohPpd+1RFbZlXmEnlexBjgJkl2owLUCrWhqd5uNw=
Message-ID: <e33ab7a4-d154-40ec-bd63-a60714d65a86@linux.microsoft.com>
Date: Wed, 22 Apr 2026 09:26:07 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [pseudo] [PATCH] Only copy xattrs on a rename if
 it's cross-filesystem
To: yocto-patches@lists.yoctoproject.org
References: <189BDB418FBB5474.2478623@lists.yoctoproject.org>
 <18A4662FFC3AFB17.657799@lists.yoctoproject.org>
Content-Language: en-US
From: Daniel Burgener <dburgener@linux.microsoft.com>
In-Reply-To: <18A4662FFC3AFB17.657799@lists.yoctoproject.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 22 Apr 2026 13:26:19 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3760

On 4/8/2026 9:55 AM, Daniel Burgener via lists.yoctoproject.org wrote:
> On 3/11/2026 1:59 PM, Daniel Burgener via lists.yoctoproject.org wrote:
>> On same file-system renames, the path update in the db means that the
>> xattrs are already present, and copying results in duplicates.=C2=A0 T=
his was
>> previously masked by the bug fixed in=20
>> d1db9c219abf92f15303486a409292237f1fc790, since that prevented the
>> xattr copying.=C2=A0 Now that that bug is fixed, we started observing =
this
>> issue in 1.9.3.
>>
>> AI-Generated: Code fix by Claude Haiku 4.5.=C2=A0 Test code by me.
>>
>> Signed-off-by: Daniel Burgener <dburgener@linux.microsoft.com>
>> ---
>> =C2=A0 pseudo_db.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 4=
 +++-
>> =C2=A0 test/test-xattr.sh | 12 ++++++++++++
>> =C2=A0 2 files changed, 15 insertions(+), 1 deletion(-)
>>
>> diff --git a/pseudo_db.c b/pseudo_db.c
>> index 9713e0c..6a33f20 100644
>> --- a/pseudo_db.c
>> +++ b/pseudo_db.c
>> @@ -2196,7 +2196,9 @@ pdb_update_inode(pseudo_msg_t *msg) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 found_existing =3D !pdb_find_file_path(=
oldmsg);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (found_existing) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* we have an e=
xisting file entry */
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pdb_copy_xattrs(oldmsg, ms=
g);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (oldmsg->dev !=3D msg->=
dev || oldmsg->ino !=3D msg->ino) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pd=
b_copy_xattrs(oldmsg, msg);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sqlite3_bind_int(update, 1, msg->dev);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sqlite3_bind_int64(update, 2, signed_in=
o(msg->ino));
>> diff --git a/test/test-xattr.sh b/test/test-xattr.sh
>> index 6ac6b3c..89fbd35 100755
>> --- a/test/test-xattr.sh
>> +++ b/test/test-xattr.sh
>> @@ -65,6 +65,18 @@ then
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 exit 1
>> =C2=A0 fi
>> +mv f1 f2
>> +attrs=3D`getfattr -d -m - f2 | grep -v '^#'`
>> +expected=3D$'security.dummy=3D"test_f2"\nuser.dummy=3D"test_f1"'
>> +if [ "$attrs" !=3D "$expected" ]
>> +then
>> +=C2=A0=C2=A0=C2=A0 #echo "Fail, unpexected getfattr result '$attrs'"
>> +=C2=A0=C2=A0=C2=A0 rm -f f1
>> +=C2=A0=C2=A0=C2=A0 rm -f f2
>> +=C2=A0=C2=A0=C2=A0 exit 1
>> +fi
>> +
>> =C2=A0 #echo "Passed."
>> =C2=A0 rm -f f1
>> +rm -f f2
>> =C2=A0 exit 0
>=20
> Gentle ping on this patch.=C2=A0 Any feedback?
>=20
> -Daniel
>=20

Pinging again on this.  If I've done something wrong in submitting,=20
please let me know so I can get this reviewed.

I'll also note that while I did use AI for the fix, this is an actual=20
bug we're encountering in our environment, not something picked up by an=20
LLM scanning the code base.  Specifically, we (in a pseudo environment)=20
populate a directory structure, and then do:

setfiles -m -v -E -F ${FILE_CONTEXTS} -r ${FOO_SQUASHFS_ROOT}=20
${FOO_SQUASHFS_ROOT}
mksquashfs "$FOO_SQUASHFS_ROOT" "$PATH_FOO" -noappend
# mv some files into ${FOO_SQUASHFS_ROOT}
setfiles -m -v -E -F ${FILE_CONTEXTS} -r ${FOO_SQUASHFS_ROOT}
mksquashfs "$FOO_SQUASHFS_ROOT" "$PATH_BAR" -noappend

We observe the second mksquashfs fail due to duplicate selinux xattrs.=20
My understanding is that the code touched in this patch seems to rename=20
the original file, which preserves the xattrs in the pseudodb, and then=20
copy the xattrs as well, resulting in duplicate xattrs.

-Daniel

