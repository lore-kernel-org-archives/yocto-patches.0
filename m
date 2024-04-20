Subject: [Poky] Do install append to mesa does nothing in scarthgap
From: joseph.mills@cnhind.com
MIME-Version: 1.0
Date: Sat, 20 Apr 2024 15:39:16 -0700
Message-ID: <0qeE.1713652756483185891.Q3Ak@lists.yoctoproject.org>
Content-Type: multipart/mixed; boundary="xmFHqN64MNzdIjRrGdsZ"
To: yocto-patches@lists.yoctoproject.org
List-ID: <yocto-patches.lists.yoctoproject.org>

--xmFHqN64MNzdIjRrGdsZ
Content-Type: multipart/alternative; boundary="uUIiOPWPhwqRgr7EcQ7d"

--uUIiOPWPhwqRgr7EcQ7d
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Line of code does nothing because the upstream code of mesa has changed.

https://git.yoctoproject.org/poky/tree/meta/recipes-graphics/mesa/mesa.inc?=
h=3Dscarthgap#n31

That line shows the replacement of #elif defined(__unix__) && defined(EGL_N=
O_X11)

This has changed upstream to #elif defined(USE_X11)

Upstream (kirkstone)

https://gitlab.freedesktop.org/mesa/mesa/-/blob/mesa-24.0.2/include/EGL/egl=
platform.h?ref_type=3Dtags#L112

Upstream (kirkstone'ish)

https://gitlab.freedesktop.org/mesa/mesa/-/blob/58ad6e52d1983785e951726f694=
0aa30e46bc462/include/EGL/eglplatform.h#L125

--uUIiOPWPhwqRgr7EcQ7d
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

<p>Line of code does nothing because the upstream code of mesa has changed.=
</p>
<p><a href=3D"https://git.yoctoproject.org/poky/tree/meta/recipes-graphics/=
mesa/mesa.inc?h=3Dscarthgap#n31" target=3D"_blank" rel=3D"noopener">https:/=
/git.yoctoproject.org/poky/tree/meta/recipes-graphics/mesa/mesa.inc?h=3Dsca=
rthgap#n31</a></p>
<p>That line shows the replacement of #elif defined(__unix__) &amp;&amp; de=
fined(EGL_NO_X11)</p>
<p>This has changed upstream to #elif defined(USE_X11)</p>
<p>&nbsp;</p>
<p>Upstream (kirkstone)</p>
<p>https://gitlab.freedesktop.org/mesa/mesa/-/blob/mesa-24.0.2/include/EGL/=
eglplatform.h?ref_type=3Dtags#L112</p>
<p>&nbsp;</p>
<p>Upstream (kirkstone'ish)</p>
<p><a href=3D"https://gitlab.freedesktop.org/mesa/mesa/-/blob/58ad6e52d1983=
785e951726f6940aa30e46bc462/include/EGL/eglplatform.h#L125" target=3D"_blan=
k" rel=3D"noopener">https://gitlab.freedesktop.org/mesa/mesa/-/blob/58ad6e5=
2d1983785e951726f6940aa30e46bc462/include/EGL/eglplatform.h#L125</a></p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>

--uUIiOPWPhwqRgr7EcQ7d--

--xmFHqN64MNzdIjRrGdsZ
Content-Type: text/x-diff; name="mesa-nox11-egl-upstream-changes.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="mesa-nox11-egl-upstream-changes.patch"

ZGlmZiAtLWdpdCBhL21ldGEvcmVjaXBlcy1ncmFwaGljcy9tZXNhL21lc2EuaW5jIGIvbWV0YS9y
ZWNpcGVzLWdyYXBoaWNzL21lc2EvbWVzYS5pbmMKaW5kZXggNmU5NjE5MDA4NC4uMzZhMTZkM2Iy
YiAxMDA2NDQKLS0tIGEvbWV0YS9yZWNpcGVzLWdyYXBoaWNzL21lc2EvbWVzYS5pbmMKKysrIGIv
bWV0YS9yZWNpcGVzLWdyYXBoaWNzL21lc2EvbWVzYS5pbmMKQEAgLTMyLDcgKzMyLDcgQEAgZG9f
aW5zdGFsbDphcHBlbmQoKSB7CiAgICMgc2VkIGNhbid0IGZpbmQgRUdML2VnbHBsYXRmb3JtLmgg
YXMgaXQgZG9lc24ndCBnZXQgaW5zdGFsbGVkIHdoZW4gZ2x2bmQgZW5hYmxlZC4KICAgIyBTbywg
Y2hlY2sgaWYgRUdML2VnbHBsYXRmb3JtLmggZXhpc3RzIGJlZm9yZSBydW5uaW5nIHNlZC4KICAg
aWYgJHtAYmIudXRpbHMuY29udGFpbnMoJ1BBQ0tBR0VDT05GSUcnLCAnZWdsJywgJ3RydWUnLCAn
ZmFsc2UnLCBkKX0gJiYgWyAtZiAke0R9JHtpbmNsdWRlZGlyfS9FR0wvZWdscGxhdGZvcm0uaCBd
OyB0aGVuCi0gICAgICBzZWQgLWkgLWUgJ3MvXiNlbGlmIGRlZmluZWQoX191bml4X18pICYmIGRl
ZmluZWQoRUdMX05PX1gxMSkkLyNlbGlmIGRlZmluZWQoX191bml4X18pIFwmXCYgZGVmaW5lZChF
R0xfTk9fWDExKSB8fCAke0BiYi51dGlscy5jb250YWlucygnUEFDS0FHRUNPTkZJRycsICd4MTEn
LCAnMCcsICcxJywgZCl9LycgJHtEfSR7aW5jbHVkZWRpcn0vRUdML2VnbHBsYXRmb3JtLmgKKyAg
ICAgIHNlZCAtaSAtZSAncy9eI2VsaWYgZGVmaW5lZChVU0VfWDExKSQvI2VsaWYgJHtAYmIudXRp
bHMuY29udGFpbnMoJ1BBQ0tBR0VDT05GSUcnLCAneDExJywgJzEnLCAnMCcsIGQpfS8nICR7RH0k
e2luY2x1ZGVkaXJ9L0VHTC9lZ2xwbGF0Zm9ybS5oCiAgIGZpCiB9CiAK

--xmFHqN64MNzdIjRrGdsZ--
