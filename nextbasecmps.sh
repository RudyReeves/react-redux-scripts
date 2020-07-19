#!/bin/bash

# Create component directories:
mkdir -p components

# Make base components:
nextcmp.sh Header sections
nextcmp.sh Main sections
nextcmp.sh Footer sections
nextcmp.sh List misc
nextcmp.sh PrimaryNav misc

cd components

# Overwrite base component implementations:
echo "import React from 'react';
import './Header.module.scss';
import PrimaryNav from 'components/misc/PrimaryNav';

type HeaderProps = {
  className?: string
};

const Header = ({
  className = 'Header'
} : HeaderProps) => {
  return (
    <>
      <header className={className}>
        <PrimaryNav />
      </header>
    </>
  );
};

export default Header;" > sections/Header/Header.tsx

echo "import React from 'react';
import './Main.module.scss';

type MainProps = {
  className?: string,
  children: any
};

const Main = ({
    className = 'Main',
    children
  } : MainProps) => {
  return (
    <>
      <main className={className}>
        {children}
      </main>
    </>
  );
};

export default Main;" > sections/Main/Main.tsx

echo "@import 'styles/globals.scss';

.Main {
  flex: 1;
}" > sections/Main/Main.module.scss

echo "import React from 'react';
import List from 'components/misc/List';
import './PrimaryNav.module.scss';

type LinkObject = {
  path: string,
  label: string
};

type PrimaryNavProps = {
  className?: string,
  links?: LinkObject[]
};

const defaultLinks = [
  {
    path: '/about',
    label: 'About'
  },
];

const PrimaryNav = ({
    className = 'PrimaryNav',
    links = defaultLinks
  } : PrimaryNavProps) => {
  return (
    <>
      <nav className={className}>
        <List
          className={\`\${className}__list\`}
          items={createLinks(links, className)}
        />
      </nav>
    </>
  );
};

const createLinks = (links: LinkObject[], className = 'PrimaryNav') => {
  return links.map((link, i) => {
    return (
      <a
        className={\`\${className}__link\`}
        href={link.path}
        rel=\"noopener\"
      >
        {link.label}
      </a>
    );
  });
};

export default PrimaryNav;" > misc/PrimaryNav/PrimaryNav.tsx

echo "@import 'styles/globals.scss';

.PrimaryNav {}

.PrimaryNav__list {
    margin: 0;
}" > misc/PrimaryNav/PrimaryNav.module.scss

echo "import React from 'react';
import './List.module.scss';

type ListProps = {
  className?: string,
  isOrdered?: boolean,
  items?: object[]
};

const List = (props : ListProps) => {
  return (
    <>
      {getList(props)}
    </>
  );
};

const getList = ({className, isOrdered = false, items = []} : ListProps) => {
  const content = createItems(items, className);
  return (isOrdered ?
    <ol className={className}>{content}</ol> :
    <ul className={className}>{content}</ul>
  );
};

const createItems = (items, className = 'List') => {
  return items.map((item, i) => {
    return (
      <li
        className={\`\${className}__item\`}
        key={i}
      >
        {item}
      </li>
    );
  });
};

export default List;" > misc/List/List.tsx
