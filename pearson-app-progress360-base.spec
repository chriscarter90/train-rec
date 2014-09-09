%define applicationdir /usr/local/pearson/app/progress360-base


%if "%{opt_suffix}" == ""
Name: pearson-app-progress360-base
%else
Name: pearson-app-progress360-base-%{opt_suffix}
%endif
Version: %{opt_version}
Release: %{opt_release}
Group: Pearson
URL: http://www.pearsoned.co.uk/
Summary: Progress360 base application package.
Vendor: Pearson
License: Pearson
AutoReqProv: no

BuildRoot: /var/tmp/%{name}-buildroot


Requires: pearson-ruby193
Requires: pearson-rubygem193-bundler
Requires: pearson-rubygems193
#Requires: mysql55-devel
#Requires: mysql55
Requires: pearson-base
BuildArch: x86_64


%description
Progress360 base application package.

%prep
# Preclude unwanted paths in gem bin/ files being picked up as dependencies.
%define _use_internal_dependency_generator 0
cat <<eof > %{_builddir}/find-requires-override
#!/bin/sh
%{__find_requires} | egrep -v '(/this/will/be/overwritten/or/wrapped/anyways/do/not/worry/ruby|/usr/bin/ruby)'
eof
chmod +x %{_builddir}/find-requires-override
%define __find_requires %{_builddir}/find-requires-override

%build
:


%install
mkdir -p $RPM_BUILD_ROOT/%{applicationdir}
cd %{opt_sourcedir}
cp -a * $RPM_BUILD_ROOT/%{applicationdir}
cp -a .bundle $RPM_BUILD_ROOT/%{applicationdir}

cd $RPM_BUILD_ROOT/%{applicationdir}
PATH=/usr/local/pearson/ruby193/bin:$PATH
bundle install --deployment --without development test assets


%clean
rm -rf $RPM_BUILD_ROOT


%files
%defattr(-, progr360, progr360)
%{applicationdir}


%pre
/usr/sbin/groupadd -g 20024 progr360 > /dev/null 2>&1
/usr/sbin/useradd -u 20024 -g 20024 -c "Progress360 user" -d %{applicationdir} \
	-s /bin/false progr360 > /dev/null 2>&1
exit 0

%changelog
* Tue Dec 10 2013 Arjun Patel arjun.patel@pearson.com
- Disable AutoReqProv to check if that improves the rpm build time

* Tue Dec 10 2013 Arjun Patel arjun.patel@pearson.com
- Ignore unicorn's weird path dependency

* Mon Dec 02 2013 Arjun Patel arjun.patel@pearson.com
- Updated with the user details and package name

* Fri Nov 29 2013 Tom ten Thij tom.ten.thij@unboxedconsulting.com
- Initial version of .spec file.
