

  select *
  FROM [Portfolio Project 1].[dbo].[Nashville]

-- Change Date
select SaleDate
FROM [Portfolio Project 1].[dbo].[Nashville]


ALTER TABLE [Portfolio Project 1].[dbo].[Nashville]
ALTER COLUMN SaleDate date

select SaleDate
FROM [Portfolio Project 1].[dbo].[Nashville]

-- Property Address Data
select *
FROM [Portfolio Project 1].[dbo].[Nashville]
order by ParcelID

Select a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress, ISNULL(a.PropertyAddress, b.PropertyAddress)
from [Portfolio Project 1]..Nashville a
join [Portfolio Project 1]..Nashville b
on a.ParcelID = b.ParcelID
and a.[UniqueID ] <> b.[UniqueID ]
where a.PropertyAddress is null

Update a
Set PropertyAddress = ISNULL(a.PropertyAddress, b.PropertyAddress)
from [Portfolio Project 1]..Nashville a
join [Portfolio Project 1]..Nashville b
on a.ParcelID = b.ParcelID
and a.[UniqueID ] <> b.[UniqueID ]
where a.PropertyAddress is null

-- Breaking the Address into Addres, City, State
Select PropertyAddress
from [Portfolio Project 1]..Nashville

-- Use -1 to get rid of comma after seperating the city
Select 
SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1 ) as Address
, SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) +1 , LEN(PropertyAddress))  as Adress
From [Portfolio Project 1]..Nashville

ALTER TABLE [Portfolio Project 1].[dbo].[Nashville]
Add PropertySplitAddress Nvarchar(255);

Update [Portfolio Project 1].[dbo].[Nashville]
Set PropertySplitAddress = SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1 ) 

ALTER TABLE [Portfolio Project 1].[dbo].[Nashville]
Add PropertySplitCity Nvarchar(255)

Update [Portfolio Project 1].[dbo].[Nashville]
Set PropertySplitCity = SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) +1 , LEN(PropertyAddress)) 


Select *
from [Portfolio Project 1]..Nashville


--Split Owner Address
Select OwnerAddress
from [Portfolio Project 1]..Nashville

Select 
PARSENAME(Replace(OwnerAddress, ',', '.'),3)
,PARSENAME(Replace(OwnerAddress, ',', '.'),2)
,PARSENAME(Replace(OwnerAddress, ',', '.'),1)
from [Portfolio Project 1]..Nashville

ALTER TABLE [Portfolio Project 1].[dbo].[Nashville]
Add OwnerSplitAddress Nvarchar(255);

Update [Portfolio Project 1].[dbo].[Nashville]
Set OwnerSplitAddress = PARSENAME(Replace(OwnerAddress, ',', '.'),3)

ALTER TABLE [Portfolio Project 1].[dbo].[Nashville]
Add OwnerSplitCity Nvarchar(255)

Update [Portfolio Project 1].[dbo].[Nashville]
Set OwnerSplitCity = PARSENAME(Replace(OwnerAddress, ',', '.'),2) 

ALTER TABLE [Portfolio Project 1].[dbo].[Nashville]
Add OwnerSplitState Nvarchar(255)

Update [Portfolio Project 1].[dbo].[Nashville]
Set OwnerSplitState = PARSENAME(Replace(OwnerAddress, ',', '.'),1)


-- Change Y and N to Yes and No
Select distinct(SoldAsVacant), COUNT(SoldAsVacant)
from [Portfolio Project 1]..Nashville
group by SoldAsVacant
order by 2

Select SoldAsVacant,
Case When SoldAsVacant = 'Y' Then 'Yes'
	 When SoldAsVacant = 'N' Then 'No'
	 Else SoldAsVacant
	 End
from [Portfolio Project 1]..Nashville

Update [Portfolio Project 1]..Nashville
Set SoldAsVacant = Case When SoldAsVacant = 'Y' Then 'Yes'
	 When SoldAsVacant = 'N' Then 'No'
	 Else SoldAsVacant
	 End

-- Remove Duplicates

-- If row_num is 2 then it is a duplicate
With RowNumCTE as (
Select *,
ROW_NUMBER() over (
Partition By ParcelID,
			 PropertyAddress,
			 SalePrice,
			 SaleDate,
			 LegalReference
			 Order By
			 UniqueID
) row_num
from [Portfolio Project 1]..Nashville
--order by ParcelID
)
Delete
from RowNumCTE
Where row_num > 1

With RowNumCTE as (
Select *,
ROW_NUMBER() over (
Partition By ParcelID,
			 PropertyAddress,
			 SalePrice,
			 SaleDate,
			 LegalReference
			 Order By
			 UniqueID
) row_num
from [Portfolio Project 1]..Nashville
--order by ParcelID
)
select * 
from RowNumCTE
Where row_num > 1

-- Delete Unused columns
Select * 
from [Portfolio Project 1]..Nashville

ALTER TABLE [Portfolio Project 1]..Nashville
DROP column OwnerAddress, TaxDistrict, PropertyAddress

