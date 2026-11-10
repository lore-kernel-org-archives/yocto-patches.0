Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.270.1794322084869630727
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 10 Nov 2026 06:48:05 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.crashing.org, ip: 63.228.1.57, mailfrom: mark.hatle@kernel.crashing.org)
Received: from kernel.crashing.org (70-99-78-136.nuveramail.net [70.99.78.136] (may be forged))
	by gate.crashing.org (8.18.1/8.18.1/Debian-2) with ESMTP id 6AAElmTX2317987;
	Tue, 10 Nov 2026 08:47:48 -0600
Received: from [192.168.2.97] ([192.168.2.97])
	by kernel.crashing.org (8.14.7/8.14.7) with ESMTP id 6AAElkaw005405;
	Tue, 10 Nov 2026 08:47:47 -0600
Message-ID: <c7bbe9c5-57fc-494a-8107-d2526125b8f8@kernel.crashing.org>
Date: Tue, 10 Nov 2026 08:47:46 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [yocto-patches] [pseudo][PATCH V2 1/2] pseudo_client: resolve
 /proc/<pid>/fd/<n> to the descriptor
To: yocto-patches@lists.yoctoproject.org, richard.purdie@linuxfoundation.org,
        chen_q07@163.com
References: <20261103013028.3295799-1-chenqi_hycx@cetc.com.cn>
 <0b977592-3cbf-494b-82e9-0659ab1408a0@kernel.crashing.org>
 <cbeb1b10-725a-464a-af1d-a70020950eca@cetc.com.cn>
Content-Language: en-US
From: Mark Hatle <mark.hatle@kernel.crashing.org>
In-Reply-To: <cbeb1b10-725a-464a-af1d-a70020950eca@cetc.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by gate.crashing.org id 6AAElmTX2317987
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Tue, 10 Nov 2026 14:48:05 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5257



On 11/10/26 3:16 AM, Chen Qi wrote:
> Hi Mark,
>=20
> Thanks a lot for reviewing this! I was quite surprised by the bugs you
> found.
> I went through the commits one by one and I think they do fix problems
> of my original patch.
>=20
> I also tested the master-next branch and I can confirm that things work
> for me.

Wonderful.  I'll go through the patches and will probably squash at least=
 some=20
of them together.  I need to evaluate the set again now that it my mornin=
g and=20
make sure squashing really makes sense here.

> I have a question on the TOCTOU section of the README.security:
>   From my understanding, pseudo uses an inode based database, so path
> based TOCTOU issues should not exist in the first place? Because if tha=
t
> happens, inode mismatch error will be reported.

My understanding (which may be wrong), is that selinux and other security=
 tools=20
will often use /proc/pid/fd/descriptor in order to get a single fd that r=
efers=20
to a file or component.  Then all subsequent actions happen against the o=
ne fd=20
making sure that a external actor can't manipulate the file via a race co=
ndition.

Introducing pseudo into the mix, we now have a series of stat, emulation=20
(processing db calls), and then open in order to perform the same action.=
  So we=20
are introducing a potential race window (for secure applications) where a=
=20
malicious actor could now change the file between the stat and the open. =
 While=20
this is all theoretical, in a running system it very much would be an att=
ack=20
vector.  (This BTW also appears to be the actual cause of the two paralle=
l=20
rename and symlink failures in the tests.  Which I'm working on a fix for=
.=20
However even with the fix, it still wouldn't be a guarenty but simply les=
s=20
likely to cause a problem.)

Basically it's a complex problem, and I wanted to make sure it was clearl=
y=20
documented for people that pseudo is not intended to be used in a secure=20
run-time environment, but instead it's part of a build system tooling to =
emulate=20
certain behavior.  Due to the nature of the emulation, it will likely nev=
er be=20
as secure as a properly implemented operating system, container environme=
nt,=20
etc.  Things we just can't do!

--Mark


> Regards,
> Qi
>=20
> On 11/10/26 10:56, Mark Hatle wrote:
>> I believe I have found some bugs in this set.=C2=A0 I worked through i=
t and
>> I THINK I have them fixed.=C2=A0 I did not squash them into your commi=
t, as
>> I'm not completely sure I understand the full workflow you are using.
>>
>> Can you please review the following commits.=C2=A0 If you agree they f=
ix
>> issues in yoru commit, I'll squash them into a single commit. See:
>>
>> https://git.yoctoproject.org/pseudo/log/?h=3Dmaster-next
>>
>>
>> Specifically the commits:
>>
>>
>> 89592a8f6c378526fdfab40396f61c97fce68d68 pseudo_client.h: remove
>> dangling pseudo_client_fdpath declaration
>> 65f48296f01ab949f0dab72e27cfda3f6ae2b45c pseudo_client: don't rewrite
>> /proc/self/fd/<n> within a chroot
>> 90789d335c990cfa37f34aa357f0fbed7133fbc6 pseudo_client: validate the
>> descriptor for /proc/self/fd/<n>/<path>
>> 914512e431dc07611c09bc9a1aefa9199463bd62 pseudo_client: only rewrite
>> /proc/<pid>/fd/<n> for this process
>> 5e4ea38a0daeabe1e05a604c2e5c3cb29570363f pseudo_client: don't use the
>> rewritten path after freeing it in base_path()
>> 21a9576df43f63ac82777166e801813ef88f8b3b pseudo_client: resolve
>> /proc/<pid>/fd/<n> to the descriptor
>>
>> (the list is from newest to oldest, so git log format)
>>
>> The first and last commits are the ones submitted.=C2=A0 The ones in t=
he
>> middle are my fixes to issues found during review and testing.
>>
>> The set in master-next also contains other changes as well as two
>> additional test cases based on your changes:
>>
>> c8770dc60339af270c8eb582d244600116889473 test-chroot-proc-dev: Add
>> /proc and /dev within a chroot test
>> 96338ee7f2b4118cd0477d7e77a5cf2df05ad5d4 test-proc-fd: Add a stale
>> directory descriptor case
>>
>> as well as a README file that I figured was necessary.=C2=A0 The LLM b=
ased
>> review pointed out that tools use the /proc interfaces to ensure a
>> reference without a race window to the fd.=C2=A0 However using pseudo =
does
>> not allow for this ability. The solution to this is we're documenting
>> it as a design decision and that users should not believe that pseudo
>> can be used in secure workflows.
>>
>>
>> Any concerns, with the above (or anything in the master-next) please
>> let me know!=C2=A0 Thank you for the submissions!=C2=A0 Sorry it took =
me so long
>> to review it.
>>
>> --Mark
>>
>> On 11/2/26 7:30 PM, Chen Qi wrote:
>>> From: Chen Qi <chenqi_hycx@cetc.com.cn>
>>>
>>> Paths such as /proc/self/fd/<n> and /dev/fd/<n> denote the open file:
>>> the
>>> kernel resolves them to the descriptor, so an O_PATH|O_NOFOLLOW
>>> descriptor
>>> on a symlink addresses the symlink itself.
>>>
>>> Path canonicalization expands them with readlink(2) and follows the
>>> result, which changes that meaning.=C2=A0 For a descriptor on a symli=
nk an
>>> xattr set through it lands on the link target instead of the link,
>>> and for
>>> a dangling symlink the call fails with ENOENT.=C2=A0 Once expanded, t=
he
>>> path no
>>> longer looks like something pseudo tracks either, so the operation is
>>> passed straight through to the real syscall.
>>>
>>> libselinux 3.11 labels the rootfs through such descriptors, so setfil=
es
>>> could not label any symlink and do_image fell back to a first boot
>>> relabel:
>>>
>>>  =C2=A0=C2=A0 setfiles: Could not set context for .../etc/mtab:=C2=A0=
 No such file or
>>> directory
>>>  =C2=A0=C2=A0 setfiles: Could not set context for
>>> .../etc/systemd/system/default.target:=C2=A0 Operation not permitted
>>>
>>> Rewrite the reference to the path pseudo recorded for the descriptor,
>>> which keeps the operation under pseudo's control.=C2=A0 The descripto=
r itself
>>> identifies the inode, so the final component is followed only when
>>> following it is what reproduces that inode, i.e. for a descriptor
>>> obtained
>>> through a symlink.=C2=A0 When the caller passes AT_SYMLINK_NOFOLLOW t=
he
>>> reference itself is what is being asked about (readlink, lstat,
>>> l*xattr),
>>> so it is left alone for the kernel to resolve.
>>>
>>> Adds test/test-proc-fd.sh covering both descriptor flavours.
>>>
>>> Assisted-by: Codewhale:deepseek-v4-flash
>>> Signed-off-by: Chen Qi <chenqi_hycx@cetc.com.cn>
>>> ---
>>>  =C2=A0 pseudo_client.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 110 +++++++++=
++++++++++++++++++
>>>  =C2=A0 pseudo_client.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 2=
 +
>>>  =C2=A0 pseudo_util.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=
=C2=A0 2 +
>>>  =C2=A0 pseudo_wrappers.c=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 2 +
>>>  =C2=A0 test/test-proc-fd.c=C2=A0 | 174 +++++++++++++++++++++++++++++=
++++++++++++++
>>>  =C2=A0 test/test-proc-fd.sh |=C2=A0 17 +++++
>>>  =C2=A0 6 files changed, 307 insertions(+)
>>>  =C2=A0 create mode 100644 test/test-proc-fd.c
>>>  =C2=A0 create mode 100755 test/test-proc-fd.sh
>>>
>>> diff --git a/pseudo_client.c b/pseudo_client.c
>>> index 302ef21..c8247e8 100644
>>> --- a/pseudo_client.c
>>> +++ b/pseudo_client.c
>>> @@ -1451,12 +1451,112 @@ pseudo_client_shutdown(int wait_on_socket) {
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>>>  =C2=A0 }
>>>  =C2=A0 +/* /proc/self/fd/<n>, /proc/<pid>/fd/<n> and /dev/fd/<n> den=
ote
>>> the open file,
>>> + * not the path the magic link prints.=C2=A0 Canonicalization resolv=
es
>>> symlinks with
>>> + * readlink(2), which changes the meaning of such a path: the kernel
>>> resolves it
>>> + * to the descriptor, so an O_PATH|O_NOFOLLOW descriptor on a
>>> symlink addresses
>>> + * the symlink itself, whereas the expansion yields the link target
>>> and then
>>> + * follows it.=C2=A0 That labels the wrong inode, or fails when the
>>> target does not
>>> + * resolve.
>>> + *
>>> + * Rewrite the reference to the path pseudo recorded for the
>>> descriptor, which
>>> + * also puts the operation under pseudo's control instead of passing
>>> it through.
>>> + * The descriptor itself identifies the inode, so the final
>>> component is only
>>> + * followed when following it is what reproduces that inode, i.e. fo=
r a
>>> + * descriptor obtained through a symlink.=C2=A0 Returns NULL to leav=
e the
>>> path alone.
>>> + */
>>> +static char *
>>> +rewrite_proc_fd_ref(const char *path, int *leave_last) {
>>> +=C2=A0=C2=A0=C2=A0 const char *p;
>>> +=C2=A0=C2=A0=C2=A0 const char *digits;
>>> +=C2=A0=C2=A0=C2=A0 const char *recpath;
>>> +=C2=A0=C2=A0=C2=A0 char *out;
>>> +=C2=A0=C2=A0=C2=A0 PSEUDO_STATBUF fbuf, pbuf;
>>> +=C2=A0=C2=A0=C2=A0 int fd =3D 0;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 if (!path || path[0] !=3D '/')
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return NULL;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 if (!strncmp(path, "/dev/fd/", 8)) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 p =3D path + 8;
>>> +=C2=A0=C2=A0=C2=A0 } else if (!strncmp(path, "/proc/", 6)) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 p =3D path + 6;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!strncmp(p, "self/fd/=
", 8)) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 p=
 +=3D 8;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else if (!strncmp(p, "t=
hread-self/fd/", 15)) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 p=
 +=3D 15;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 c=
onst char *q =3D p;
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 w=
hile (*q >=3D '0' && *q <=3D '9')
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 ++q;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 i=
f (q =3D=3D p || strncmp(q, "/fd/", 4))
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 return NULL;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 p=
 =3D q + 4;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> +=C2=A0=C2=A0=C2=A0 } else {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return NULL;
>>> +=C2=A0=C2=A0=C2=A0 }
>>> +
>>> +=C2=A0=C2=A0=C2=A0 digits =3D p;
>>> +=C2=A0=C2=A0=C2=A0 while (*p >=3D '0' && *p <=3D '9') {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (fd > (0x7fffffff - 9)=
 / 10)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 r=
eturn NULL;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fd =3D fd * 10 + (*p - '0=
');
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ++p;
>>> +=C2=A0=C2=A0=C2=A0 }
>>> +=C2=A0=C2=A0=C2=A0 if (p =3D=3D digits || (*p !=3D '\0' && *p !=3D '=
/'))
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return NULL;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 recpath =3D fd_path(fd);
>>> +=C2=A0=C2=A0=C2=A0 if (!recpath || recpath[0] !=3D '/')
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return NULL;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 /* Within a chroot the recorded path carries the =
chroot prefix,
>>> while
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * base_path() adds that prefix to absolute =
paths.=C2=A0 Strip it, or
>>> give up
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * if the descriptor is not inside the chroo=
t.
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 */
>>> +=C2=A0=C2=A0=C2=A0 if (pseudo_chroot_len) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (strncmp(recpath, pseu=
do_chroot, pseudo_chroot_len) ||
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (=
recpath[pseudo_chroot_len] !=3D '\0' &&
>>> recpath[pseudo_chroot_len] !=3D '/'))
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 r=
eturn NULL;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 recpath +=3D pseudo_chroo=
t_len;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (*recpath =3D=3D '\0')
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 r=
ecpath =3D "/";
>>> +=C2=A0=C2=A0=C2=A0 }
>>> +
>>> +=C2=A0=C2=A0=C2=A0 if (*p !=3D '\0') {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 size_t len =3D strlen(rec=
path) + strlen(p) + 1;
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 out =3D malloc(len);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!out)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 r=
eturn NULL;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 snprintf(out, len, "%s%s"=
, recpath, p);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return out;
>>> +=C2=A0=C2=A0=C2=A0 }
>>> +
>>> +=C2=A0=C2=A0=C2=A0 if (!pseudo_real_fstat || !pseudo_real_lstat)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return NULL;
>>> +=C2=A0=C2=A0=C2=A0 if (pseudo_real_fstat(fd, &fbuf) =3D=3D -1)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return NULL;
>>> +=C2=A0=C2=A0=C2=A0 if (pseudo_real_lstat(recpath, &pbuf) =3D=3D 0 &&
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pbuf.st_dev =3D=3D fbuf.s=
t_dev && pbuf.st_ino =3D=3D fbuf.st_ino) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *leave_last =3D 1;
>>> +=C2=A0=C2=A0=C2=A0 } else if (pseudo_real_stat =3D=3D NULL || pseudo=
_real_stat(recpath,
>>> &pbuf) =3D=3D -1 ||
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pbuf.st=
_dev !=3D fbuf.st_dev || pbuf.st_ino !=3D fbuf.st_ino) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* The recorded path no l=
onger describes this descriptor. */
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return NULL;
>>> +=C2=A0=C2=A0=C2=A0 }
>>> +=C2=A0=C2=A0=C2=A0 return strdup(recpath);
>>> +}
>>> +
>>>  =C2=A0 static char *
>>>  =C2=A0 base_path(int dirfd, const char *path, int leave_last) {
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 char *basepath =3D 0;
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 size_t baselen =3D 0;
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 size_t minlen =3D 0;
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 char *newpath;
>>> +=C2=A0=C2=A0=C2=A0 char *rewritten;
>>>  =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!path)
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return NULL;
>>> @@ -1501,7 +1601,17 @@ base_path(int dirfd, const char *path, int
>>> leave_last) {
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 minlen =3D ps=
eudo_chroot_len;
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>  =C2=A0 +=C2=A0=C2=A0=C2=A0 /* Only when the caller follows the final=
 component. With
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * AT_SYMLINK_NOFOLLOW the reference itself =
is what the caller asks
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * about (readlink, lstat, l*xattr), so it m=
ust be left for the
>>> kernel
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * to resolve.
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 */
>>> +=C2=A0=C2=A0=C2=A0 rewritten =3D leave_last ? NULL : rewrite_proc_fd=
_ref(path,
>>> &leave_last);
>>> +=C2=A0=C2=A0=C2=A0 if (rewritten)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 path =3D rewritten;
>>> +
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 newpath =3D pseudo_fix_path(basepath,=
 path, minlen, baselen,
>>> NULL, leave_last);
>>> +=C2=A0=C2=A0=C2=A0 free(rewritten);
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pseudo_debug(PDBGF_PATH, "base_path[%=
s]: %s</>%s =3D> %s\n",
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 leave_last ? =
"nofollow" : "follow",
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 basepath ? ba=
sepath : "<nil>",
>>> diff --git a/pseudo_client.h b/pseudo_client.h
>>> index 9b9f86a..b3f9f49 100644
>>> --- a/pseudo_client.h
>>> +++ b/pseudo_client.h
>>> @@ -51,6 +51,8 @@ extern FILE *pseudo_grp;
>>>  =C2=A0 =C2=A0 /* pseudo_wrappers will try to initialize these */
>>>  =C2=A0 extern int (*pseudo_real_lstat)(const char *path, PSEUDO_STAT=
BUF
>>> *buf);
>>> +extern int (*pseudo_real_fstat)(int fd, PSEUDO_STATBUF *buf);
>>> +extern int (*pseudo_real_stat)(const char *path, PSEUDO_STATBUF *buf=
);
>>>  =C2=A0 extern int (*pseudo_real_fork)(void);
>>>  =C2=A0 extern int (*pseudo_real_execv)(const char *, char * const *)=
;
>>>  =C2=A0 diff --git a/pseudo_util.c b/pseudo_util.c
>>> index 6e7c465..12718a5 100644
>>> --- a/pseudo_util.c
>>> +++ b/pseudo_util.c
>>> @@ -99,6 +99,8 @@ static int pseudo_util_initted =3D -1;=C2=A0 /* Not=
 yet
>>> run */
>>>  =C2=A0 =C2=A0 /* bypass wrapper logic on path computations */
>>>  =C2=A0 int (*pseudo_real_lstat)(const char *path, PSEUDO_STATBUF *bu=
f) =3D
>>> NULL;
>>> +int (*pseudo_real_fstat)(int fd, PSEUDO_STATBUF *buf) =3D NULL;
>>> +int (*pseudo_real_stat)(const char *path, PSEUDO_STATBUF *buf) =3D N=
ULL;
>>>  =C2=A0 /* bash workaround */
>>>  =C2=A0 int (*pseudo_real_unsetenv)(const char *) =3D unsetenv;
>>>  =C2=A0 char * (*pseudo_real_getenv)(const char *) =3D getenv;
>>> diff --git a/pseudo_wrappers.c b/pseudo_wrappers.c
>>> index 16a451a..d073b1e 100644
>>> --- a/pseudo_wrappers.c
>>> +++ b/pseudo_wrappers.c
>>> @@ -174,6 +174,8 @@ pseudo_init_wrappers(void) {
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pseudo_real_fsetxattr =3D real_fsetxa=
ttr;
>>>  =C2=A0 #endif
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pseudo_real_lstat =3D base_lstat;
>>> +=C2=A0=C2=A0=C2=A0 pseudo_real_fstat =3D base_fstat;
>>> +=C2=A0=C2=A0=C2=A0 pseudo_real_stat =3D base_stat;
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* and these are used so the client's=
 server spawn can bypass
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * wrappers.
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>>> diff --git a/test/test-proc-fd.c b/test/test-proc-fd.c
>>> new file mode 100644
>>> index 0000000..9550809
>>> --- /dev/null
>>> +++ b/test/test-proc-fd.c
>>> @@ -0,0 +1,174 @@
>>> +/*
>>> + * SPDX-License-Identifier: LGPL-2.1-only
>>> + *
>>> + * Check that xattr operations on /proc/self/fd/<n> address the file
>>> the
>>> + * descriptor refers to, and not the path the magic link prints.
>>> + *
>>> + * A descriptor opened with O_PATH|O_NOFOLLOW on a symlink denotes t=
he
>>> + * symlink itself, so a context set through it must land on the link
>>> and
>>> + * leave the target alone.=C2=A0 A descriptor opened by following a =
symlink
>>> + * denotes the target, so the context must land there instead.
>>> + *
>>> + * Exit status: 0 all checks passed, 1 a check failed, 255 skipped
>>> because
>>> + * the platform has no xattr support.
>>> + */
>>> +#define _GNU_SOURCE
>>> +#include <errno.h>
>>> +#include <fcntl.h>
>>> +#include <stdio.h>
>>> +#include <stdlib.h>
>>> +#include <string.h>
>>> +#include <unistd.h>
>>> +#include <sys/stat.h>
>>> +#include <sys/types.h>
>>> +#include <sys/xattr.h>
>>> +
>>> +#define CTX "security.selinux"
>>> +
>>> +static int failures;
>>> +
>>> +static void
>>> +fail(const char *what, const char *detail)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 printf("=C2=A0 FAIL=C2=A0 %-52s %s\n", what, deta=
il);
>>> +=C2=A0=C2=A0=C2=A0 ++failures;
>>> +}
>>> +
>>> +static void
>>> +pass(const char *what)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 printf("=C2=A0 PASS=C2=A0 %s\n", what);
>>> +}
>>> +
>>> +/* Read the context of path itself, without following a final symlin=
k.
>>> + * Returns NULL when there is none.
>>> + */
>>> +static const char *
>>> +get_ctx(const char *path, char *buf, size_t buflen)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 ssize_t n =3D lgetxattr(path, CTX, buf, buflen - =
1);
>>> +
>>> +=C2=A0=C2=A0=C2=A0 if (n < 0)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return NULL;
>>> +=C2=A0=C2=A0=C2=A0 buf[n] =3D '\0';
>>> +=C2=A0=C2=A0=C2=A0 return buf;
>>> +}
>>> +
>>> +static void
>>> +expect_ctx(const char *what, const char *path, const char *want)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 char buf[256];
>>> +=C2=A0=C2=A0=C2=A0 const char *got =3D get_ctx(path, buf, sizeof buf=
);
>>> +
>>> +=C2=A0=C2=A0=C2=A0 if (!want) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (got)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 f=
ail(what, got);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 else
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 p=
ass(what);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
>>> +=C2=A0=C2=A0=C2=A0 }
>>> +=C2=A0=C2=A0=C2=A0 if (got && strcmp(got, want) =3D=3D 0)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pass(what);
>>> +=C2=A0=C2=A0=C2=A0 else
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fail(what, got ? got : "<=
no context>");
>>> +}
>>> +
>>> +/* Set the context through the descriptor, the same way libselinux
>>> does when
>>> + * it pins a file: path-based call, no extra flags.
>>> + */
>>> +static int
>>> +set_via_fd(int fd, const char *value)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 char path[64];
>>> +
>>> +=C2=A0=C2=A0=C2=A0 snprintf(path, sizeof path, "/proc/self/fd/%d", f=
d);
>>> +=C2=A0=C2=A0=C2=A0 return setxattr(path, CTX, value, strlen(value) +=
 1, 0);
>>> +}
>>> +
>>> +int
>>> +main(int argc, char **argv)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 const char *dir =3D argc > 1 ? argv[1] : ".";
>>> +=C2=A0=C2=A0=C2=A0 char path[512];
>>> +=C2=A0=C2=A0=C2=A0 int fd;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 snprintf(path, sizeof path, "%s/file", dir);
>>> +=C2=A0=C2=A0=C2=A0 if (close(open(path, O_CREAT | O_WRONLY, 0644)) =3D=
=3D -1) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 perror(path);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 1;
>>> +=C2=A0=C2=A0=C2=A0 }
>>> +=C2=A0=C2=A0=C2=A0 snprintf(path, sizeof path, "%s/link", dir);
>>> +=C2=A0=C2=A0=C2=A0 if (symlink("file", path) =3D=3D -1) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 perror(path);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 1;
>>> +=C2=A0=C2=A0=C2=A0 }
>>> +=C2=A0=C2=A0=C2=A0 snprintf(path, sizeof path, "%s/dangling", dir);
>>> +=C2=A0=C2=A0=C2=A0 if (symlink("/nonexistent/xyz", path) =3D=3D -1) =
{
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 perror(path);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 1;
>>> +=C2=A0=C2=A0=C2=A0 }
>>> +
>>> +=C2=A0=C2=A0=C2=A0 /* 1. O_PATH|O_NOFOLLOW on a symlink: label the l=
ink, not its
>>> target. */
>>> +=C2=A0=C2=A0=C2=A0 snprintf(path, sizeof path, "%s/link", dir);
>>> +=C2=A0=C2=A0=C2=A0 fd =3D open(path, O_PATH | O_NOFOLLOW);
>>> +=C2=A0=C2=A0=C2=A0 if (fd =3D=3D -1) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 perror(path);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 1;
>>> +=C2=A0=C2=A0=C2=A0 }
>>> +=C2=A0=C2=A0=C2=A0 if (set_via_fd(fd, "onlink") =3D=3D -1 && errno =3D=
=3D ENOTSUP) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 printf("=C2=A0 SKIP=C2=A0=
 xattr support unavailable\n");
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 255;
>>> +=C2=A0=C2=A0=C2=A0 }
>>> +=C2=A0=C2=A0=C2=A0 close(fd);
>>> +
>>> +=C2=A0=C2=A0=C2=A0 snprintf(path, sizeof path, "%s/link", dir);
>>> +=C2=A0=C2=A0=C2=A0 expect_ctx("context landed on the symlink", path,=
 "onlink");
>>> +=C2=A0=C2=A0=C2=A0 snprintf(path, sizeof path, "%s/file", dir);
>>> +=C2=A0=C2=A0=C2=A0 expect_ctx("context did not land on the target", =
path, NULL);
>>> +
>>> +=C2=A0=C2=A0=C2=A0 /* 2. A dangling symlink must not make the operat=
ion fail. */
>>> +=C2=A0=C2=A0=C2=A0 snprintf(path, sizeof path, "%s/dangling", dir);
>>> +=C2=A0=C2=A0=C2=A0 fd =3D open(path, O_PATH | O_NOFOLLOW);
>>> +=C2=A0=C2=A0=C2=A0 if (fd =3D=3D -1) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 perror(path);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 1;
>>> +=C2=A0=C2=A0=C2=A0 }
>>> +=C2=A0=C2=A0=C2=A0 if (set_via_fd(fd, "ondangling") =3D=3D -1) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fail("context set on a da=
ngling symlink", strerror(errno));
>>> +=C2=A0=C2=A0=C2=A0 } else {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pass("context set on a da=
ngling symlink");
>>> +=C2=A0=C2=A0=C2=A0 }
>>> +=C2=A0=C2=A0=C2=A0 close(fd);
>>> +=C2=A0=C2=A0=C2=A0 expect_ctx("context landed on the dangling link",=
 path,
>>> "ondangling");
>>> +
>>> +=C2=A0=C2=A0=C2=A0 /* 3. A descriptor obtained by following a symlin=
k denotes the
>>> target. */
>>> +=C2=A0=C2=A0=C2=A0 snprintf(path, sizeof path, "%s/target", dir);
>>> +=C2=A0=C2=A0=C2=A0 if (close(open(path, O_CREAT | O_WRONLY, 0644)) =3D=
=3D -1) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 perror(path);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 1;
>>> +=C2=A0=C2=A0=C2=A0 }
>>> +=C2=A0=C2=A0=C2=A0 snprintf(path, sizeof path, "%s/link2", dir);
>>> +=C2=A0=C2=A0=C2=A0 if (symlink("target", path) =3D=3D -1) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 perror(path);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 1;
>>> +=C2=A0=C2=A0=C2=A0 }
>>> +=C2=A0=C2=A0=C2=A0 fd =3D open(path, O_RDONLY);
>>> +=C2=A0=C2=A0=C2=A0 if (fd =3D=3D -1) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 perror(path);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 1;
>>> +=C2=A0=C2=A0=C2=A0 }
>>> +=C2=A0=C2=A0=C2=A0 if (set_via_fd(fd, "ontarget") =3D=3D -1) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fail("context set through=
 a followed descriptor",
>>> strerror(errno));
>>> +=C2=A0=C2=A0=C2=A0 } else {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pass("context set through=
 a followed descriptor");
>>> +=C2=A0=C2=A0=C2=A0 }
>>> +=C2=A0=C2=A0=C2=A0 close(fd);
>>> +
>>> +=C2=A0=C2=A0=C2=A0 snprintf(path, sizeof path, "%s/target", dir);
>>> +=C2=A0=C2=A0=C2=A0 expect_ctx("context landed on the target", path, =
"ontarget");
>>> +=C2=A0=C2=A0=C2=A0 snprintf(path, sizeof path, "%s/link2", dir);
>>> +=C2=A0=C2=A0=C2=A0 expect_ctx("context did not land on the link", pa=
th, NULL);
>>> +
>>> +=C2=A0=C2=A0=C2=A0 printf("%s: %d check(s) failed\n", failures ? "FA=
IL" : "OK",
>>> failures);
>>> +=C2=A0=C2=A0=C2=A0 return failures ? 1 : 0;
>>> +}
>>> diff --git a/test/test-proc-fd.sh b/test/test-proc-fd.sh
>>> new file mode 100755
>>> index 0000000..4a7f8ba
>>> --- /dev/null
>>> +++ b/test/test-proc-fd.sh
>>> @@ -0,0 +1,17 @@
>>> +#!/bin/bash
>>> +#
>>> +# SPDX-License-Identifier: LGPL-2.1-only
>>> +#
>>> +# Regressions guarded here: an xattr call on /proc/self/fd/<n> must
>>> address
>>> +# the file the descriptor refers to.=C2=A0 Path canonicalization use=
d to
>>> expand the
>>> +# magic link with readlink(2) and then follow the result, so a
>>> context set
>>> +# through an O_PATH|O_NOFOLLOW descriptor on a symlink landed on the
>>> link
>>> +# target, and a dangling link made the call fail with ENOENT.
>>> libselinux 3.11
>>> +# labels the rootfs that way, which left every symlink in the image
>>> unlabelled.
>>> +#
>>> +# The temporary tree has to live below $PWD so that pseudo tracks it.
>>> +
>>> +tmpdir=3D"$(mktemp -d -p "$PWD" proc_fd_XXXXXX)"
>>> +trap "rm -rf '$tmpdir'" EXIT TERM INT
>>> +
>>> +./test/test-proc-fd "$tmpdir"
>>
>>
>>
>=20
>=20
>=20
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#5256): https://lists.yoctoproject.org/g/yocto-patch=
es/message/5256
> Mute This Topic: https://lists.yoctoproject.org/mt/122070118/3616948
> Group Owner: yocto-patches+owner@lists.yoctoproject.org
> Unsubscribe: https://lists.yoctoproject.org/g/yocto-patches/leave/13201=
099/3616948/947757854/xyzzy [mark.hatle@kernel.crashing.org]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>=20
