Return-Path: <mark.hatle@kernel.crashing.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64267FF8850
	for <webhook@archiver.kernel.org>; Fri, 24 Apr 2026 22:16:51 +0000 (UTC)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.1045.1777069007469463375
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 24 Apr 2026 15:16:47 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.crashing.org, ip: 63.228.1.57, mailfrom: mark.hatle@kernel.crashing.org)
Received: from kernel.crashing.org (70-99-78-136.nuveramail.net [70.99.78.136] (may be forged))
	by gate.crashing.org (8.18.1/8.18.1/Debian-2) with ESMTP id 63OMGkM5279480
	for <yocto-patches@lists.yoctoproject.org>; Fri, 24 Apr 2026 17:16:46 -0500
Received: from [192.168.2.236] ([192.168.2.236])
	by kernel.crashing.org (8.14.7/8.14.7) with ESMTP id 63OMGjfk024674
	for <yocto-patches@lists.yoctoproject.org>; Fri, 24 Apr 2026 17:16:46 -0500
Message-ID: <44b1a4bf-541c-49fd-bf41-8dfa5dc91463@kernel.crashing.org>
Date: Fri, 24 Apr 2026 17:16:45 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [pseudo] [PATCH] Only copy xattrs on a rename if
 it's cross-filesystem
Content-Language: en-US
To: yocto-patches@lists.yoctoproject.org
References: <189BDB418FBB5474.2478623@lists.yoctoproject.org>
 <18A4662FFC3AFB17.657799@lists.yoctoproject.org>
 <e33ab7a4-d154-40ec-bd63-a60714d65a86@linux.microsoft.com>
From: Mark Hatle <mark.hatle@kernel.crashing.org>
In-Reply-To: <e33ab7a4-d154-40ec-bd63-a60714d65a86@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by gate.crashing.org id 63OMGkM5279480
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 24 Apr 2026 22:16:51 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3812

We'll look into this soon.  Sorry, missed the original patch and the ping=
 was in=20
the middle of my absence.

--Mark

On 4/22/26 8:26 AM, Daniel Burgener via lists.yoctoproject.org wrote:
> On 4/8/2026 9:55 AM, Daniel Burgener via lists.yoctoproject.org wrote:
>> On 3/11/2026 1:59 PM, Daniel Burgener via lists.yoctoproject.org wrote=
:
>>> On same file-system renames, the path update in the db means that the
>>> xattrs are already present, and copying results in duplicates.=C2=A0 =
This was
>>> previously masked by the bug fixed in
>>> d1db9c219abf92f15303486a409292237f1fc790, since that prevented the
>>> xattr copying.=C2=A0 Now that that bug is fixed, we started observing=
 this
>>> issue in 1.9.3.
>>>
>>> AI-Generated: Code fix by Claude Haiku 4.5.=C2=A0 Test code by me.
>>>
>>> Signed-off-by: Daniel Burgener <dburgener@linux.microsoft.com>
>>> ---
>>>  =C2=A0 pseudo_db.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=
 4 +++-
>>>  =C2=A0 test/test-xattr.sh | 12 ++++++++++++
>>>  =C2=A0 2 files changed, 15 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/pseudo_db.c b/pseudo_db.c
>>> index 9713e0c..6a33f20 100644
>>> --- a/pseudo_db.c
>>> +++ b/pseudo_db.c
>>> @@ -2196,7 +2196,9 @@ pdb_update_inode(pseudo_msg_t *msg) {
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 found_existing =3D !pdb_find_file_pat=
h(oldmsg);
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (found_existing) {
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* we have an=
 existing file entry */
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pdb_copy_xattrs(oldmsg, m=
sg);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (oldmsg->dev !=3D msg-=
>dev || oldmsg->ino !=3D msg->ino) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 p=
db_copy_xattrs(oldmsg, msg);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sqlite3_bind_int(update, 1, msg->dev)=
;
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sqlite3_bind_int64(update, 2, signed_=
ino(msg->ino));
>>> diff --git a/test/test-xattr.sh b/test/test-xattr.sh
>>> index 6ac6b3c..89fbd35 100755
>>> --- a/test/test-xattr.sh
>>> +++ b/test/test-xattr.sh
>>> @@ -65,6 +65,18 @@ then
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 exit 1
>>>  =C2=A0 fi
>>> +mv f1 f2
>>> +attrs=3D`getfattr -d -m - f2 | grep -v '^#'`
>>> +expected=3D$'security.dummy=3D"test_f2"\nuser.dummy=3D"test_f1"'
>>> +if [ "$attrs" !=3D "$expected" ]
>>> +then
>>> +=C2=A0=C2=A0=C2=A0 #echo "Fail, unpexected getfattr result '$attrs'"
>>> +=C2=A0=C2=A0=C2=A0 rm -f f1
>>> +=C2=A0=C2=A0=C2=A0 rm -f f2
>>> +=C2=A0=C2=A0=C2=A0 exit 1
>>> +fi
>>> +
>>>  =C2=A0 #echo "Passed."
>>>  =C2=A0 rm -f f1
>>> +rm -f f2
>>>  =C2=A0 exit 0
>>
>> Gentle ping on this patch.=C2=A0 Any feedback?
>>
>> -Daniel
>>
>=20
> Pinging again on this.  If I've done something wrong in submitting,
> please let me know so I can get this reviewed.
>=20
> I'll also note that while I did use AI for the fix, this is an actual
> bug we're encountering in our environment, not something picked up by a=
n
> LLM scanning the code base.  Specifically, we (in a pseudo environment)
> populate a directory structure, and then do:
>=20
> setfiles -m -v -E -F ${FILE_CONTEXTS} -r ${FOO_SQUASHFS_ROOT}
> ${FOO_SQUASHFS_ROOT}
> mksquashfs "$FOO_SQUASHFS_ROOT" "$PATH_FOO" -noappend
> # mv some files into ${FOO_SQUASHFS_ROOT}
> setfiles -m -v -E -F ${FILE_CONTEXTS} -r ${FOO_SQUASHFS_ROOT}
> mksquashfs "$FOO_SQUASHFS_ROOT" "$PATH_BAR" -noappend
>=20
> We observe the second mksquashfs fail due to duplicate selinux xattrs.
> My understanding is that the code touched in this patch seems to rename
> the original file, which preserves the xattrs in the pseudodb, and then
> copy the xattrs as well, resulting in duplicate xattrs.
>=20
> -Daniel
>=20
>=20
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#3760): https://lists.yoctoproject.org/g/yocto-patch=
es/message/3760
> Mute This Topic: https://lists.yoctoproject.org/mt/118265101/3616948
> Group Owner: yocto-patches+owner@lists.yoctoproject.org
> Unsubscribe: https://lists.yoctoproject.org/g/yocto-patches/leave/13201=
099/3616948/947757854/xyzzy [mark.hatle@kernel.crashing.org]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>=20
>=20

